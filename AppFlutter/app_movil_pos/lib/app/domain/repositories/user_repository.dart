import '../models/user/user_create/select_option/user_data_option.dart';
import '../models/user/user_create/user_create_request.dart';

abstract class UserRepository {
  Future<UserDataOption> getUserDataOption();
  Future<void> createUser(UserCreateRequest request);
}
