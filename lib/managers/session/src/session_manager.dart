import 'package:logger/logger.dart';
import 'package:mobile_app/managers/session/interface/i_session_manager.dart';
import 'package:mobile_app/managers/session/interface/i_user_holder.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';

class SessionManager implements ISessionManager {
  final IUserHolder _userHolder;
  final IUserProvider _provider;

  SessionManager({
    required IUserHolder userHolder,
    required IUserProvider provider,
  })  : _userHolder = userHolder,
        _provider = provider;

  @override
  IUserHolder get userHolder => _userHolder;

  @override
  bool get isSessionStarted => _userHolder.currentUser is User;

  @override
  Future<void> startSession() async {
    final user = await _provider.fetchUser();
    if (user is! User) {
      Logger().w("Session isn't started: user not found");
      return;
    }

    await _userHolder.initialize(user: user);

    Logger().i('Session for user ${user.uid} started');
  }

  @override
  Future<void> endSession() async {
    if (_userHolder.hasUser) {
      await _provider.signOut(user: _userHolder.currentUser!);
      Logger().i('Session for user ${_userHolder.currentUser?.uid} ended');
    }

    await _userHolder.dispose();
  }
}
