import '../../domain/models/user/user_create/select_option/user_data_option.dart';
import '../../domain/models/user/user_create/user_create_request.dart';
import '../../domain/repositories/user_repository.dart';
import '../services/remoto/user_service.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._userCrearServices);

  final UserService _userCrearServices;

  @override
  Future<void> createUser(UserCreateRequest request) async {
    await _userCrearServices.createUser(
      request: request,
      onSucces: (_) {},
    );
  }

  @override
  Future<UserDataOption> getUserDataOption() async {
    final userDataOption = await _userCrearServices.getUserDataOption();
    return userDataOption ??
        const UserDataOption(
          categoriaNegocios: [],
          departamentos: [],
        );
  }
}
