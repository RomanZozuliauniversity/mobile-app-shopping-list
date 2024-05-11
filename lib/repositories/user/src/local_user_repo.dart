import 'dart:convert';

import 'package:mobile_app/models/auth/auth_result.dart';
import 'package:mobile_app/models/user/user.dart';
import 'package:mobile_app/repositories/user/interface/i_user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _activeUserKey = 'active-user';

class LocalUserRepo implements IUserRepo {
  const LocalUserRepo();

  @override
  Future<User?> fetchUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (!sharedPreferences.containsKey(_activeUserKey)) return null;

    final email = sharedPreferences.getString(_activeUserKey);
    if (email is! String) return null;

    final userJson = sharedPreferences.getString(email);

    if (userJson is! String) {
      sharedPreferences.remove(email);
      return null;
    }

    return User.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
  }

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (!sharedPreferences.containsKey(email)) {
      return AuthResult(
        errorMessage: 'No users found with such email',
      );
    }

    final userJson = sharedPreferences.getString(email);

    if (userJson is! String) {
      sharedPreferences.remove(email);
      return AuthResult(
        errorMessage: 'User record invalid, registration required',
      );
    }

    final user = User.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
    if (user.password != password) {
      return AuthResult(
        errorMessage: 'Invalid password',
      );
    }
    if (rememberMe) {
      await sharedPreferences.setString(_activeUserKey, user.email);
    }

    return AuthResult(user: user);
  }

  @override
  Future<AuthResult> register({required User user}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey(user.email)) {
      return AuthResult(
        errorMessage: 'User with exact email already exists',
      );
    }

    await Future.wait([
      sharedPreferences.setString(_activeUserKey, user.email),
      sharedPreferences.setString(user.email, jsonEncode(user.toJson())),
    ]);

    return AuthResult(user: user);
  }

  @override
  Future<void> signOut({required User user}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove(_activeUserKey);
  }

  @override
  Future<void> updateUser({required User user}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(user.email, jsonEncode(user.toJson()));
  }
}
