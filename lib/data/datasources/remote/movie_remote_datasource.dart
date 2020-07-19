import 'package:flutter/material.dart';

import 'package:flutter_movie_app/common/network/http/movie_client.dart';
import 'package:flutter_movie_app/common/utils/remote_utils.dart';
import 'package:flutter_movie_app/data/models/movie_image_model.dart';
import 'package:flutter_movie_app/data/models/movie_model.dart';

class MovieRemoteDataSource {
  final MovieClient movieClient;

  MovieRemoteDataSource({@required this.movieClient});

  Future<List<MovieModel>> fetchMovieList({String type}) async {
    final response = await movieClient.get(type ?? '');
    final data = <MovieModel>[];
    getData(response).forEach((item) {
      data.add(MovieModel.fromJson(item));
    });

    return data;
  }

  Future<MovieModel> fetchMovieDetail(String movieId) async {
    final response = await movieClient.get(movieId ?? '');
    return MovieModel.fromJson(response);
  }

  Future<MovieImageModel> fetchMovieImages(String movieId) async {
    final response = await movieClient.get('$movieId/images');
    return MovieImageModel.fromJson(response);
  }
}
