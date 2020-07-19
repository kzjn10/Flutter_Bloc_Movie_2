abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  // final DataConnectionChecker connectionChecker;

  NetworkInfoImpl();

  @override
  Future<bool> get isConnected => Future<bool>.value(true);
}
