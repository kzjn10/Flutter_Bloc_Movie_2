import 'dart:io';

import 'package:flutter_movie_app/common/exceptions/network_connection_exception.dart';
import 'package:flutter_movie_app/common/network/network_info.dart';
import 'package:flutter_movie_app/data/datasources/remote/movie_remote_datasource.dart';
import 'package:flutter_movie_app/data/models/movie_image_model.dart';
import 'package:flutter_movie_app/data/models/movie_model.dart';
import 'package:flutter_movie_app/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final NetworkInfoImpl networkInfo;
  final MovieRemoteDataSource movieRemoteDataSource;

  MovieRepositoryImpl(this.networkInfo, this.movieRemoteDataSource);

  @override
  Future<MovieModel> fetchMovieDetail({String movieId}) async {
    if (await networkInfo.isConnected) {
      return movieRemoteDataSource.fetchMovieDetail(movieId);
    }
    throw NetworkConnectionException();
  }

  @override
  Future<MovieImageModel> fetchMovieImages({String movieId}) async {
    if (await networkInfo.isConnected) {
      return movieRemoteDataSource.fetchMovieImages(movieId);
    }
    throw NetworkConnectionException();
  }

  @override
  Future<List<MovieModel>> fetchMovieList({String type}) async {
    if (await networkInfo.isConnected) {
      return movieRemoteDataSource.fetchMovieList(type: type);
    }
    throw NetworkConnectionException();
  }
}
