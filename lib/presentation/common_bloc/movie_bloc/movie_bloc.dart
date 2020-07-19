import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_movie_app/domain/entities/movie_image_entity.dart';
import 'package:flutter_movie_app/domain/usecases/movie_usecase.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieUseCase movieUseCase;

  MovieBloc({this.movieUseCase}) : super(InitMovieState());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    switch (event.runtimeType) {
      case FetchMovieListEvent:
        yield* _fetchMovieList(event);
        break;
      case FetchMovieDetailEvent:
        yield* _fetchMovieDetail(event);
        break;
      case FetchMovieGraphicEvent:
        yield* _fetchMovieGraphic(event);
        break;
      default:
        break;
    }
  }

  Stream<MovieState> _fetchMovieList(FetchMovieListEvent event) async* {
    try {
      yield FetchMovieListState();

      final movieList = await movieUseCase.getMovieList(type: event.type);

      if (movieList?.isNotEmpty ?? false) {
        yield LoadedMovieListState(data: movieList);
      } else {
        yield FailToLoadMovieListState();
      }
    } catch (_) {
      yield FailToLoadMovieListState();
    }
  }

  Stream<MovieState> _fetchMovieDetail(FetchMovieDetailEvent event) async* {
    try {
      yield FetchMovieDetailState();

      final movieData = await movieUseCase.getMovieDetail(id: event.movieId);
      if (movieData != null) {
        yield LoadedMovieDetailState(data: movieData);
      } else {
        yield FailToLoadMovieDetailState();
      }
    } catch (_) {
      yield FailToLoadMovieDetailState();
    }
  }

  Stream<MovieState> _fetchMovieGraphic(FetchMovieGraphicEvent event) async* {
    try {
      yield FetchMovieGraphicState();

      final movieData = await movieUseCase.getMovieImages(id: event.movieId);
      if (movieData != null) {
        yield LoadedMovieGraphicState(data: movieData);
      } else {
        yield FailToLoadMovieGraphicState();
      }
    } catch (_) {
      yield FailToLoadMovieGraphicState();
    }
  }
}
