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

class ServerException implements Exception {
  final String message;
  final String code;
  final List<ErrorList> errors;

  ServerException({this.message, this.code, this.errors});
}
