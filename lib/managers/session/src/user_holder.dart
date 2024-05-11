import 'package:mobile_app/managers/session/interface/i_user_holder.dart';

class UserHolder implements IUserHolder {
  User? _currentUser;

  @override
  bool get hasUser => _currentUser is User;

  @override
  User? get currentUser => _currentUser;

  @override
  Future<void> initialize({required User user}) async {
    _currentUser = user;
  }

  @override
  Future<void> dispose() async {
    _currentUser = null;
  }
}
