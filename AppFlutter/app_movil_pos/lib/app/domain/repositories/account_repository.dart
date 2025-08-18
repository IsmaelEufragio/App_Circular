import '../models/user/user/user.dart';

abstract class AccountRepository {
  Future<User?> getUserData();
}
