import 'package:mobile_app/managers/session/interface/i_user_holder.dart';

abstract class ISessionManager {
  bool get isSessionStarted;

  IUserHolder get userHolder;

  Future<void> startSession();
  Future<void> endSession();
}
