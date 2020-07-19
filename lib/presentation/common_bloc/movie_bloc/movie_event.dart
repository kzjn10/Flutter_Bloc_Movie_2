part of 'movie_bloc.dart';

abstract class MovieEvent {
  bool isFromRemote;

  MovieEvent({this.isFromRemote});
}

class FetchMovieListEvent extends MovieEvent {
  final String type;
  final bool fromRemote;

  FetchMovieListEvent({
    @required this.type,
    this.fromRemote = true,
  }) : super(isFromRemote: fromRemote);
}

class FetchMovieDetailEvent extends MovieEvent {
  final String movieId;
  final bool fromRemote;
  FetchMovieDetailEvent({@required this.movieId, this.fromRemote = true})
      : super(isFromRemote: fromRemote);
}

class FetchMovieGraphicEvent extends MovieEvent {
  final String movieId;
  final bool fromRemote;
  FetchMovieGraphicEvent({@required this.movieId, this.fromRemote = true})
      : super(isFromRemote: fromRemote);
}
