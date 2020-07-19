class AppException implements Exception {
  final String error;
  final String message;

  AppException({this.error, this.message});
}
