import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../domain/either/either.dart';

part 'failure.dart';
part 'logs.dart';
part 'parse_respose_body.dart';

enum HttpMethod { get, post, patch, delete, put }

class Http {
  Http(
    this._client, {
    required String baseUrl,
    required String apiKey,
  })  : _baseUrl = baseUrl,
        _apiKey = apiKey;

  final Client _client;
  final String _baseUrl;
  final String _apiKey;
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
      } else {
        url = url.replace(
          queryParameters: {
            'language': languageCode,
          },
        );
      }
      headers = {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
        ...headers
      };
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
}
