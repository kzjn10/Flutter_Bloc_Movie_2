enum HttpMethodType { post, get, put, patch, delete }

class HttpMethod {
  HttpMethodType type;

  HttpMethod({this.type});

  @override
  String toString() {
    switch (type) {
      case HttpMethodType.post:
        return 'POST';
        break;
      case HttpMethodType.get:
        return 'GET';
        break;
      case HttpMethodType.put:
        return 'PUT';
        break;
      case HttpMethodType.patch:
        return 'PATCH';
        break;
      case HttpMethodType.delete:
        return 'DELETE';
        break;
      default:
        return '';
    }
  }
}
