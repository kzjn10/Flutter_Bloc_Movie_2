import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';

import 'package:insurance/common/configs/default_env.dart';
import 'package:insurance/common/constants/authen_constants.dart';
import 'package:insurance/common/utils/device_utils.dart';
import 'package:insurance/common/utils/preferences.dart';

class Configurations {
  static String _insuranceHost = DefaultConfig.insuranceHost;
  static String _environment = DefaultConfig.environment;
  static String _deviceInfo = '';
  static String _token = '';
  static bool _isForceShowLog = false;
  static String _appVersion = '';
  static String _phoneNumber = '';

  Future<void> setConfigurationValues(Map<String, dynamic> value) async {
    final deviceInfo = await getDeviceInfoJson();
    final packageInfo = await PackageInfo.fromPlatform();

    final prefs = await Preference.load;

    _insuranceHost = value['insurance_host'] ?? DefaultConfig.insuranceHost;
    _environment = kReleaseMode ? 'pro' : DefaultConfig.environment;
    _isForceShowLog = value['forceShowLog'] ?? DefaultConfig.isForceShowLog;
    _token = prefs.getString(AuthenticateConstants.token);
    _phoneNumber = prefs.getString(AuthenticateConstants.phone);
    _deviceInfo = base64.encode(utf8.encode(jsonEncode(deviceInfo ?? '')));
    _appVersion = packageInfo?.version ?? '';
  }

  static String get environment => _environment;

  static String get insuranceHost => _insuranceHost;

  static String get deviceInfo => _deviceInfo;

  static String get token => _token;

  static String get appVersion => _appVersion;

  static bool get forceShowLog => _isForceShowLog;

  static String get phoneNumber => _phoneNumber;

  int getIntegerValue(String value, int defaultValue) {
    if (value == null || value.isEmpty || int.parse(value) == null) {
      return defaultValue;
    } else {
      return int.parse(value);
    }
  }
}
