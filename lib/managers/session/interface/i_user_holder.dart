import 'package:mobile_app/models/user/user.dart';
export 'package:mobile_app/models/user/user.dart';

abstract class IUserHolder {
  bool get hasUser;
  User? get currentUser;

  Future<void> initialize({required User user});
  Future<void> dispose();
}
