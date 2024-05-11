import 'package:mobile_app/models/auth/auth_result.dart';
import 'package:mobile_app/models/user/user.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/repositories/user/interface/i_user_repo.dart';
import 'package:mobile_app/repositories/user/src/local_user_repo.dart';

class UserProvider implements IUserProvider {
  final IUserRepo _repo;

  const UserProvider({
    IUserRepo repo = const LocalUserRepo(),
  }) : _repo = repo;

  @override
  Future<User?> fetchUser() => _repo.fetchUser();

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) =>
      _repo.login(email: email, password: password, rememberMe: rememberMe);

  @override
  Future<AuthResult> register({required User user}) =>
      _repo.register(user: user);

  @override
  Future<void> signOut({required User user}) => _repo.signOut(user: user);

  @override
  Future<void> updateUser({required User user}) => _repo.updateUser(user: user);
}
