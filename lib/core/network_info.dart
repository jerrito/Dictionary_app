import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  String get noNetowrkMessage;
}

class NetworkInfoImpl extends NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;

  NetworkInfoImpl({
    required this.dataConnectionChecker,
  });

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;

  @override
  String get noNetowrkMessage => 'No internet connection';
}
