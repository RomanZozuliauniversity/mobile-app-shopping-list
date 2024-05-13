import 'package:mobile_app/models/auth/auth_result.dart';
import 'package:mobile_app/models/user/user.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/repositories/user/interface/i_user_repo.dart';
import 'package:mobile_app/repositories/user/src/firebase_user_repo.dart';
import 'package:mobile_app/repositories/user/src/local_user_repo.dart';
import 'package:mobile_app/services/network/network_service.dart';

class UserProvider implements IUserProvider {
  final IUserRepo _repo;
  final IUserRepo _localRepo = const LocalUserRepo();

  const UserProvider({
    IUserRepo repo = const FirebaseUserRepo(),
  }) : _repo = repo;

  @override
  Future<User?> fetchUser() async {
    if (await NetworkService().isConnected) return _repo.fetchUser();

    return _localRepo.fetchUser();
  }

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    if (await NetworkService().isConnected) {
      _localRepo.login(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );

      return _repo.login(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );
    }

    return _localRepo.login(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }

  @override
  Future<AuthResult> register({required User user}) async {
    if (await NetworkService().isConnected) {
      _localRepo.register(user: user);
      return _repo.register(user: user);
    }

    return _localRepo.register(user: user);
  }

  @override
  Future<void> signOut({required User user}) async {
    _localRepo.signOut(user: user);
    _repo.signOut(user: user);
  }

  @override
  Future<void> updateUser({required User user}) async {
    _localRepo.updateUser(user: user);
    _repo.updateUser(user: user);
  }
}
