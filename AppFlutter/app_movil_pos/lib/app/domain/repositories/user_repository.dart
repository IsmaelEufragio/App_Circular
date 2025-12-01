import '../models/user/user_create/select_option/user_data_option.dart';

abstract class UserRepository {
  Future<UserDataOption> getUserDataOption();
}
