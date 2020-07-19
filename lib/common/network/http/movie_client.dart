import 'http_client.dart';
import 'http_constants.dart';

class InsuranceClient extends HttpClient {
  InsuranceClient()
      : super(
          host: HttpConstants.host,
          header: getAuthenticationHeader(),
        );

  static Map<String, String> getAuthenticationHeader() {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }
}
