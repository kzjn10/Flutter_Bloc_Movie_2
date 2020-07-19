import 'package:flutter_movie_app/data/models/movie_image_model.dart';
import 'package:flutter_movie_app/data/models/movie_model.dart';

abstract class MovieRepository {
  Future<MovieModel> fetchMovieDetail({String movieId});

  Future<MovieImageModel> fetchMovieImages({String movieId});

  Future<List<MovieModel>> fetchMovieList({String type});
}
