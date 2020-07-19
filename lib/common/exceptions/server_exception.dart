class ErrorList {
  String message;
  String code;
  String key;

  ErrorList({
    this.message,
    this.code = '',
    this.key = '',
  });

  ErrorList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    key = json['key'];
  }
}

class BaseException implements Exception {
  final String message;
  final String code;
  final List<ErrorList> errors;

  BaseException({this.message, this.code, this.errors});
}
