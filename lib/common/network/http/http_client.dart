import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';
import 'package:mime/mime.dart';

import 'package:insurance/common/constants/http_constants.dart';
import 'package:insurance/common/network/http/http_method_enum.dart';
import 'package:insurance/common/utils/http_util.dart';
import 'package:insurance/common/utils/logger_utils.dart';

class HttpClient {
  Client _client;
  String host;
  Map<String, String> header;

  HttpClient({@required this.host, @required this.header}) {
    _client = Client();
  }

  Uri _getParsedUrl(String path) {
    return Uri.parse('$host$path');
  }

  dynamic get(String path) async {
    LoggerUtils.instance.i('[GET] ${_getParsedUrl(path)}');
    LoggerUtils.instance.i('[HEADER] ${header.toString()}');

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

    LoggerUtils.instance.i('[POST] ${_getParsedUrl(path)}');
    LoggerUtils.instance.i('[HEADER] ${header.toString()}');
    LoggerUtils.instance.i('[DATA] ${data.toString()}');

    final response = await _client.post(
      _getParsedUrl(path),
      body: HttpUtil.encodeRequestBody(
          json.encode(data), requestHeader[HttpConstants.contentType]),
      headers: requestHeader,
    );

    return HttpUtil.getResponse(response);
  }

  dynamic patch(String path, dynamic data,
      {Map<String, dynamic> overrideHeader}) async {
    final Map<String, String> requestHeader = overrideHeader ?? header;
    final response = await _client.patch(
      _getParsedUrl(path),
      body: HttpUtil.encodeRequestBody(
          data, requestHeader[HttpConstants.contentType]),
      headers: requestHeader,
    );

    return HttpUtil.getResponse(response);
  }

  dynamic put(String path, dynamic data) async {
    final response = await _client.put(
      _getParsedUrl(path),
      body: json.encode(data),
      headers: header,
    );

    return HttpUtil.getResponse(response);
  }

  dynamic delete(String path) async {
    final response = await _client.delete(
      _getParsedUrl(path),
      headers: header,
    );

    return HttpUtil.getResponse(response);
  }

  dynamic uploadFile(String path, Map<String, File> mapFile,
      [HttpMethodType method = HttpMethodType.post,
      Map<String, dynamic> overrideHeader]) async {
    header[HttpConstants.contentType] = HttpConstants.multiPartFormDataType;

    final request = MultipartRequest(
        HttpMethod(type: method).toString(), _getParsedUrl(path));

    request.headers.addAll(header);

    mapFile?.forEach((key, value) async {
      final mimeTypeData =
          lookupMimeType(value.path, headerBytes: [0xFF, 0xD8]).split('/');
      return request.files.add(
        await MultipartFile.fromPath(
          key,
          value.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
      );
    });

    final response = await Response.fromStream(await request.send());
    return HttpUtil.getResponse(response);
  }
}
