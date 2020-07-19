part of 'movie_bloc.dart';

abstract class MovieState {}

class InitMovieState extends MovieState {}

class FetchMovieListState extends MovieState {}

class LoadedMovieListState extends MovieState {
  final List<MovieEntity> data;

  LoadedMovieListState({this.data});
}

class FailToLoadMovieListState extends MovieState {}

class FetchMovieDetailState extends MovieState {}

class LoadedMovieDetailState extends MovieState {
  final MovieEntity data;

  LoadedMovieDetailState({this.data});
}

class FailToLoadMovieDetailState extends MovieState {}

class FetchMovieGraphicState extends MovieState {}

class LoadedMovieGraphicState extends MovieState {
  final MovieImageEntity data;

  LoadedMovieGraphicState({this.data});
}

class FailToLoadMovieGraphicState extends MovieState {}
