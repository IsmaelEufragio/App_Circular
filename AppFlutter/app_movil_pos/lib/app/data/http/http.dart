import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:http/http.dart';

import '../../domain/either/either.dart';
import '../../domain/failures/sign_in/sign_in_failure.dart';
import '../../domain/models/authentication/accessToken/accessToken.dart';
import '../../domain/models/authentication/refresToken/refresToken.dart';
import '../services/local/session_service.dart';

part 'failure.dart';
part 'logs.dart';
part 'parse_respose_body.dart';

enum HttpMethod { get, post, patch, delete, put }

class Http {
  Http(
    this._client, {
    required String baseUrl,
    required String apiKey,
    required SessionSevices sessionSevices,
  })  : _baseUrl = baseUrl,
        _sessionSevices = sessionSevices;

  final Client _client;
  final String _baseUrl;

  final SessionSevices _sessionSevices;
  // ignore: prefer_final_fields
  //String _lenguageCode;

  Future<Either<HttpFailure, R>> request<R>(
    String patch, {
    required R Function(dynamic responseBody) onSucces,
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
    String languageCode = 'en',
    Duration timeout = const Duration(seconds: 10),
    bool authentication = true,
  }) async {
    Map<String, dynamic> logs = {};
    try {
      Uri url = Uri.parse(
        patch.startsWith('htpp') ? patch : '$_baseUrl$patch',
      );
      if (queryParameters.isNotEmpty) {
        url = url.replace(
          queryParameters: {
            ...queryParameters,
            'language': languageCode,
          },
        );
      }
      headers = {'Content-Type': 'application/json', ...headers};
      if (authentication) {
        if (await isAuthenticated()) {
          final accessTokenModel = await _sessionSevices.accessToken;
          headers = {
            'Authorization': 'Bearer ${accessTokenModel!.tokenAccess}',
            ...headers
          };
        } else {
          return Either.left(
            HttpFailure(
              statusCode: 401,
              data: 'Unauthorized',
            ),
          );
        }
      }
      late final Response response;
      final String bodyString = jsonEncode(body);

      logs = {
        'starTime': DateTime.now().toString(),
        'url': url.toString(),
        'method': method.name,
        'body': body,
        'headers': headers
      };

      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url, headers: headers).timeout(timeout);
        case HttpMethod.post:
          response = await _client
              .post(
                url,
                headers: headers,
                body: bodyString,
              )
              .timeout(timeout);
        case HttpMethod.patch:
          response = await _client
              .patch(
                url,
                headers: headers,
                body: bodyString,
              )
              .timeout(timeout);
        case HttpMethod.delete:
          response = await _client
              .delete(
                url,
                headers: headers,
                body: bodyString,
              )
              .timeout(timeout);
        case HttpMethod.put:
          response = await _client
              .put(
                url,
                headers: headers,
                body: bodyString,
              )
              .timeout(timeout);
      }

      final statusCode = response.statusCode;
      final responseBody = _parseResponseBody(response.body);
      logs = {...logs, 'statusCode': statusCode, 'responseBody': responseBody};

      if (statusCode >= 200 && statusCode <= 300) {
        return Either.right(onSucces(responseBody));
      }

      return Either.left(HttpFailure(
        statusCode: statusCode,
        data: responseBody,
      ));
    } catch (e, stackTrace) {
      logs = {
        ...logs,
        'exception': e.runtimeType.toString(),
        'stackTrace': stackTrace.toString(),
      };
      if (e is SocketException || e is ClientException) {
        logs = {
          ...logs,
          'exception': 'NetworkException',
        };
        return Either.left(HttpFailure(exception: NetworkException()));
      }
      return Either.left(HttpFailure(exception: e));
    } finally {
      logs = {
        ...logs,
        'endTime': DateTime.now().toString(),
      };
      _printLogs(logs);
    }
  }

  Future<Either<HttpFailure, R>> requestGraphQL<R>({
    required String query,
    required R Function(dynamic responseBody) onSucces,
    bool authentication = true,
  }) async {
    final httpLink = graphql.HttpLink('$_baseUrl/graphql/');
    if (authentication && !await isAuthenticated()) {
      return Either.left(
        HttpFailure(
          statusCode: 401,
          data: 'Unauthorized',
        ),
      );
    }
    final tokenAccessModel = await _sessionSevices.accessToken;
    final tokenAccess = tokenAccessModel?.tokenAccess ?? '';
    final authLink = graphql.AuthLink(
      getToken: () async => 'Bearer $tokenAccess',
    );

    final link = authentication ? authLink.concat(httpLink) : httpLink;

    final client = graphql.GraphQLClient(
      cache: graphql.GraphQLCache(),
      link: link,
    );

    try {
      final result = await client.query(
        graphql.QueryOptions(document: graphql.gql(query)),
      );

      if (result.hasException) {
        return Either.left(
          HttpFailure(
            statusCode: 500,
            data: 'Nose que pedo.',
          ),
        );
      }
      return Either.right(onSucces(result.data));
    } catch (e) {
      return Either.left(
        HttpFailure(
          statusCode: 500,
          data: 'Nose que pedo.',
        ),
      );
    }
  }

  Future<bool> isAuthenticated() async {
    final accessToken = await _sessionSevices.accessToken;
    final boolAccess = accessToken != null;
    final refresToken = await _sessionSevices.refresToken;
    final boolRefres = await _sessionSevices.refresToken != null;
    final credential = await _sessionSevices.rememberCredential;
    final correo = await _sessionSevices.correo;
    final password = await _sessionSevices.password;
    if (!boolAccess) {
      if (!boolRefres) {
        if (credential) {
          if (correo != null && password != null) {
            final result = await getRefresToken(correo, password);
            return result.when(
              left: (failure) async {
                return false;
              },
              right: (success) async {
                return true;
              },
            );
          }
          return false;
        }
        return false;
      } else {
        final validRefres = DateTime.now().isBefore(refresToken!.expira);
        if (validRefres) {
          final requestTokenAccess = await createRequestTokenAccess(
            refresToken: refresToken.refresToken,
          );
          return requestTokenAccess.when(
            left: (failure) async {
              return false;
            },
            right: (accessToken) async {
              _sessionSevices.saveAccessToken(accessToken);
              return true;
            },
          );
        } else {
          if (credential && correo != null && password != null) {
            final result = await getRefresToken(correo, password);
            return result.when(
              left: (failure) async {
                return false;
              },
              right: (success) async {
                return true;
              },
            );
          }
          return false;
        }
      }
    } else {
      final validAccess = DateTime.now().isBefore(accessToken.expira);
      if (validAccess) {
        return true;
      } else {
        if (boolRefres) {
          final validRefres = DateTime.now().isBefore(refresToken!.expira);
          if (validRefres) {
            final requestTokenAccess = await createRequestTokenAccess(
              refresToken: refresToken.refresToken,
            );
            return requestTokenAccess.when(
              left: (failure) async {
                return false;
              },
              right: (accessToken) async {
                _sessionSevices.saveAccessToken(accessToken);
                return true;
              },
            );
          } else {
            if (credential && correo != null && password != null) {
              final result = await getRefresToken(correo, password);
              return result.when(
                left: (failure) async {
                  return false;
                },
                right: (success) async {
                  return true;
                },
              );
            } else {
              return false;
            }
          }
        } else {
          if (credential && correo != null && password != null) {
            final result = await getRefresToken(correo, password);
            return result.when(
              left: (failure) async {
                return false;
              },
              right: (success) async {
                return true;
              },
            );
          } else {
            return false;
          }
        }
      }
    }
  }

  Future<Either<dynamic, dynamic>> getRefresToken(correo, password) async {
    final result =
        await createRequestTokenRefres(username: correo, password: password);
    return result.when(
      left: (failure) async {
        _sessionSevices.deleteCredential();
        return Either.left(false);
      },
      right: (token) async {
        _sessionSevices.saveRefresToken(token);
        final requestTokenAccess = await createRequestTokenAccess(
          refresToken: token.refresToken,
        );
        return requestTokenAccess.when(
          left: (failure) async {
            return Either.left(false);
          },
          right: (accessToken) async {
            _sessionSevices.saveAccessToken(accessToken);
            return Either.right(true);
          },
        );
      },
    );
  }

  Either<SignInFailure, T> handleFailure<T>(HttpFailure failure) {
    if (failure.statusCode != null) {
      switch (failure.statusCode) {
        case 401:
          if (failure.data is Map &&
              (failure.data as Map)['status_code'] == 32) {
            return Either.left(const SignInFailure.notVerified());
          }
          return Either.left(const SignInFailure.unauthorized());
        case 404:
          return Either.left(const SignInFailure.notFound());
        default:
          return Either.left(const SignInFailure.unknown());
      }
    }
    if (failure.exception is NetworkException) {
      return Either.left(const SignInFailure.network());
    }
    return Either.left(const SignInFailure.unknown());
  }

  Future<Either<SignInFailure, RefresToken>> createRequestTokenRefres({
    required String username,
    required String password,
  }) async {
    final result = await request('/Autenticacion/TokenRefres',
        method: HttpMethod.patch,
        authentication: false,
        body: {
          'correo': username,
          'password': password,
        }, onSucces: (responseBody) {
      final json = responseBody as Map;
      final data = json['data'];
      return RefresToken.fromJson(data);
    });
    return result.when(
      left: handleFailure,
      right: (responseBody) {
        return Either.right(responseBody);
      },
    );
  }

  Future<Either<SignInFailure, AccessToken>> createRequestTokenAccess(
      {required String refresToken}) async {
    final result = await request('/Autenticacion/TokenDeAcceso',
        method: HttpMethod.patch,
        timeout: const Duration(seconds: 30),
        authentication: false,
        body: {
          'refresToken': refresToken,
        }, onSucces: (responseBody) {
      final json = responseBody as Map;
      final data = json['data'];
      return AccessToken.fromJson(data);
    });

    return result.when(
      left: handleFailure,
      right: (responseBody) {
        return Either.right(responseBody);
      },
    );
  }
}
