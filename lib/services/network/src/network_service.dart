import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:mobile_app/services/network/interface/i_network_service.dart';

class NetworkService implements INetworkService {
  final Connectivity _connectivity = Connectivity();
  final RxBool _isConnected = RxBool(false);

  NetworkService();

  @override
  RxBool get isConnected => _isConnected;

  @override
  Future<void> startListener() async {
    _onConnectivityChanged(await _connectivity.checkConnectivity());

    _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    _isConnected.value = results.last != ConnectivityResult.none &&
        results.last != ConnectivityResult.bluetooth;
  }
}
