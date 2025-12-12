import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection _connectionChecker;
  final Connectivity _connectivity;

  NetworkInfoImpl({
    required InternetConnection connectionChecker,
    required Connectivity connectivity,
  }) : _connectionChecker = connectionChecker,
       _connectivity = connectivity;

  @override
  Future<bool> get isConnected => _connectionChecker.hasInternetAccess;

  @override
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.asyncMap((_) async {
      return await _connectionChecker.hasInternetAccess;
    });
  }
}
