import 'package:mobile_app/models/auth/auth_result.dart';
import 'package:mobile_app/models/user/user.dart';

abstract class IUserProvider {
  Future<AuthResult> login({
    required String email,
    required String password,
    bool rememberMe = false,
  });
  Future<AuthResult> register({required User user});
  Future<void> signOut({required User user});

  Future<User?> fetchUser();
  Future<void> updateUser({required User user});
}
