import 'package:flutter_movie_app/common/constants/exception_constants.dart';
import 'package:flutter_movie_app/common/exceptions/server_exception.dart';

class ServerErrorException extends BaseException {
  ServerErrorException(Map<String, dynamic> error)
      : super(
          message: error['message'],
          code: ExceptionConstants.internalServerError,
          errors: <ErrorList>[],
        );
}
