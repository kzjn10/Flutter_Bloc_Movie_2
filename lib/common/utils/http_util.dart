import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:insurance/common/constants/http_constants.dart';
import 'package:insurance/common/event_bus/event_bus.dart';
import 'package:insurance/common/exceptions/server_error_exception.dart';
import 'package:insurance/common/utils/logger_utils.dart';
import 'package:insurance/common/utils/remote_utils.dart';
import 'package:insurance/presentation/event_bus/authen/authen_emitter_events.dart';

class HttpUtil {
  static dynamic encodeRequestBody(dynamic data, String contentType) {
    return contentType == HttpConstants.jsonContentType
        ? utf8.encode(json.encode(data))
        : data;
  }

  static dynamic getResponse(Response response) {
    debugPrint('>>>>>>> ${response.body}');
    switch (response.statusCode) {
      case 200:
        return _getSuccessResponse(response);
      case 403:
        LoggerUtils.instance.i(getErrorResult(json.decode(response.body)));
        EventBus.emit(UnauthenticatedEmitterEvent());
        break;
      default:
        throw ServerErrorException(
          getErrorResult(json.decode(response.body)),
        );
    }
  }

  static dynamic _getSuccessResponse(Response response) {
    final _responseJson = json.decode(response.body);

    LoggerUtils.instance.i('[RESPONSE] $_responseJson');

    return _responseJson;
  }
}
