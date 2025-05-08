import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NetworkService extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late Timer _monitorTimer;
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  NetworkService() {
    _setup();
  }

  void _setup() {
    _checkInitialStatus();
    _startMonitoring();
  }

  Future<void> _checkInitialStatus() async {
    final result = await _connectivity.checkConnectivity();
    final ConnectivityResult status;
    status = (result.isNotEmpty ? result.first : ConnectivityResult.none);

    _handleStatusChange(status);
  }

  void _startMonitoring() {
    _monitorTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final result = await _connectivity.checkConnectivity();
      final ConnectivityResult status;
      status = (result.isNotEmpty ? result.first : ConnectivityResult.none);

      _handleStatusChange(status);
    });
  }

  void _handleStatusChange(ConnectivityResult status) {
    final bool currentStatus = status != ConnectivityResult.none;
    if (currentStatus != _isConnected) {
      _isConnected = currentStatus;
      notifyListeners();
      _showConnectionMessage(currentStatus);
    }
  }

  void _showConnectionMessage(bool connected) {
    Fluttertoast.showToast(
      msg: connected
          ? 'Connection restored'
          : 'Connection lost',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  @override
  void dispose() {
    _monitorTimer.cancel();
    super.dispose();
  }
}
