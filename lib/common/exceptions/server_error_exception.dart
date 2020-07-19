import 'package:insurance/common/constants/exception_constants.dart';
import 'package:insurance/common/exceptions/server_exception.dart';

class ServerErrorException extends ServerException {
  ServerErrorException(Map<String, dynamic> error)
      : super(
          message: error['message'],
          code: ExceptionConstants.internalServerError,
          errors: [],
        );
}
