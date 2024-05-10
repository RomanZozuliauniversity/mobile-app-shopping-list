import 'package:mobile_app/models/user/user.dart';

class AuthResult {
  final User? user;
  final String? errorMessage;

  AuthResult({
    this.user,
    this.errorMessage,
  });
}
