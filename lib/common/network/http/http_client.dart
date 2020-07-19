import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'package:flutter_movie_app/common/network/http_constants.dart';
import 'package:flutter_movie_app/common/utils/http_util.dart';

class HttpClient {
  Client _client;
  String host;
  String apiKey;
  Map<String, String> header;

  HttpClient(
      {@required this.host, @required this.header, @required this.apiKey}) {
    _client = Client();
  }

  Uri _getParsedUrl(String path) {
    return Uri.parse('$host$path?api_key=$apiKey');
  }

  dynamic get(String path) async {
    debugPrint('>>>>>>> [GET] ${_getParsedUrl(path)}');

    final response = await _client.get(
      _getParsedUrl(path),
      headers: header,
    );

    return HttpUtil.getResponse(response);
  }

  Future<Response> downloadFile(String path) async {
    final response = await _client.get(
      _getParsedUrl(path),
      headers: header,
    );
    return response.statusCode == 201 ? response : null;
  }

  dynamic post(String path, dynamic data,
      {Map<String, dynamic> overrideHeader}) async {
    final Map<String, String> requestHeader = overrideHeader ?? header;

    debugPrint('>>>>>>> [POST] ${_getParsedUrl(path)}');
    debugPrint('>>>>>>> [HEADER] ${header.toString()}');
    debugPrint('>>>>>>> [DATA] ${data.toString()}');

    final response = await _client.post(
      _getParsedUrl(path),
      body: HttpUtil.encodeRequestBody(
          json.encode(data), requestHeader[HttpConstants.contentType]),
      headers: requestHeader,
    );

    return HttpUtil.getResponse(response);
  }
}
