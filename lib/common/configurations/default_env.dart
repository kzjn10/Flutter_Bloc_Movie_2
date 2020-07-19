class DefaultConfig {
  static const host = 'http://api.themoviedb.org/3/movie/';
  static const imageHost = 'https://image.tmdb.org/t/p/';
  static const apiKey = '802b2c4b88ea1183e50e6b285a27696e';
  static const httpClientType = HttpClientEnum.http;
}

enum HttpClientEnum { http, dio, retrofit }
