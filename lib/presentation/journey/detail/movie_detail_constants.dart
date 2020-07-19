class MovieDetailConstants {
  static const contentMargin = 20.0;
  static const contentMarginBottom = 50.0;
  static const contentHorizontalPadding = 20.0;
  static const contentVerticalPadding = 20.0;
}

class MovieDetailArguments {
  final String movieId;
  final String coverPath;
  final String title;

  MovieDetailArguments({this.movieId, this.coverPath, this.title});
}
