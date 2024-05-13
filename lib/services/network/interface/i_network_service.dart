import 'package:get/get.dart';

abstract class INetworkService {
  RxBool get isConnected;

  Future<void> startListener();
}
