import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InternetConnectionController extends GetxController {
  bool _connectionStatus = false;
  bool _isLoading = true;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  bool get connectionStatus => _connectionStatus;

  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    _isLoading = true;
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      return;
    }
    await _updateConnectionStatus(result);
    _isLoading = false;
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    bool hasInternet = await _checkInternetAccess();
    if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
      _connectionStatus = true;
      if (!hasInternet) {
        _connectionStatus = false;
      }
    } else if (result == ConnectivityResult.none) {
      _connectionStatus = false;
    }
  }

  Future<bool> _checkInternetAccess() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com'));
      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
