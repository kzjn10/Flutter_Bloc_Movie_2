import 'default_env.dart';

class Configurations {
  static String _host = DefaultConfig.host;
  static String _imageHost = DefaultConfig.imageHost;
  static String _apiKey = '';
  static String _httpClientType = '';

  Future<void> setConfigurationValues(Map<String, dynamic> value) async {
    _host = value['host'] ?? DefaultConfig.host;
    _imageHost = value['image_host'] ?? DefaultConfig.imageHost;
    _apiKey = value['token'] ?? DefaultConfig.apiKey;
    _httpClientType =
        value['client_type'] ?? DefaultConfig.httpClientType.toString();
  }

  static String get host => _host;

  static String get imageHost => _imageHost;

  static String get apiKey => _apiKey;

  static String get httpClientType => _httpClientType;
}
