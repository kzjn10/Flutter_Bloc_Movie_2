import 'package:flutter/material.dart';

import 'package:flutter_movie_app/domain/entities/movie_entity.dart';
import 'package:flutter_movie_app/domain/entities/movie_image_entity.dart';
import 'package:flutter_movie_app/domain/repositories/movie_repository.dart';

class MovieUseCase {
  final MovieRepository movieRepository;

  MovieUseCase({this.movieRepository});

  Future<List<MovieEntity>> getMovieList(
      {String type, bool fromRemote = true}) async {
    return movieRepository.fetchMovieList(type: type);
  }

  Future<MovieEntity> getMovieDetail(
      {@required String id, bool fromRemote = true}) async {
    return movieRepository.fetchMovieDetail(movieId: id);
  }

  Future<MovieImageEntity> getMovieImages(
      {@required String id, bool fromRemote = true}) async {
    return movieRepository.fetchMovieImages(movieId: id);
  }
}
