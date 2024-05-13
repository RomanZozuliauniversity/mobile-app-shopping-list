import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkService {
  final Connectivity _connectivity;
  final List<ValueChanged<bool>> _callbacks = [];

  static final NetworkService _singleton = NetworkService._internal(
    connectivity: Connectivity(),
  );

  factory NetworkService() => _singleton;

  NetworkService._internal({
    required Connectivity connectivity,
  }) : _connectivity = connectivity;

  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();

    return results.last != ConnectivityResult.none &&
        results.last != ConnectivityResult.bluetooth;
  }

  void onConnectivityChanged() {
    _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
  }

  void subscribe(ValueChanged<bool> callback) {
    _callbacks.add(callback);
  }

  void unsubscribe(ValueChanged<bool> callback) {
    _callbacks.remove(callback);
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    for (var callback in _callbacks) {
      callback(
        results.last != ConnectivityResult.none &&
            results.last != ConnectivityResult.bluetooth,
      );
    }
  }
}
