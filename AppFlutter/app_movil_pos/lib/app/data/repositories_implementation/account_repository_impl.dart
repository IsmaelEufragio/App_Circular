import '../../domain/models/user/user/user.dart';
import '../../domain/repositories/account_repository.dart';
import '../services/remoto/account_service.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(this._accountServices);

  final AccountServices _accountServices;
  @override
  Future<User?> getUserData() async {
    final user = await _accountServices.getAccount();
    return user;
  }
}
