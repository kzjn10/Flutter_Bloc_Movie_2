import 'package:flutter_movie_app/domain/entities/collection_entity.dart';
import 'package:flutter_movie_app/domain/entities/company_entity.dart';
import 'package:flutter_movie_app/domain/entities/country_entity.dart';
import 'package:flutter_movie_app/domain/entities/genre_entity.dart';
import 'package:flutter_movie_app/domain/entities/language_entity.dart';

class MovieEntity {
  bool adult;
  String backdropPath;
  CollectionEntity belongsToCollection;
  int budget;
  List<GenreEntity> genres = [];
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<CompanyEntity> productionCompanies = [];
  List<CountryEntity> productionCountries = [];
  String releaseDate;
  int revenue;
  int runtime;
  List<LanguageEntity> spokenLanguages = [];
  String status;
  String tagLine;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieEntity({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagLine,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
}
