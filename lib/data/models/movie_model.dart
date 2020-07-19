import 'package:flutter_movie_app/data/models/collection_model.dart';
import 'package:flutter_movie_app/data/models/company_model.dart';
import 'package:flutter_movie_app/data/models/country_model.dart';
import 'package:flutter_movie_app/data/models/genre_model.dart';
import 'package:flutter_movie_app/data/models/language_model.dart';
import 'package:flutter_movie_app/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    bool adult,
    String backdropPath,
    CollectionModel belongsToCollection,
    int budget,
    List<GenreModel> genres,
    String homepage,
    int id,
    String imdbId,
    String originalLanguage,
    String originalTitle,
    String overview,
    double popularity,
    String posterPath,
    List<CompanyModel> productionCompanies,
    List<CountryModel> productionCountries,
    String releaseDate,
    int revenue,
    int runtime,
    List<LanguageModel> spokenLanguages,
    String status,
    String tagLine,
    String title,
    bool video,
    double voteAverage,
    int voteCount,
  }) : super(
          adult: adult,
          backdropPath: backdropPath,
          belongsToCollection: belongsToCollection,
          budget: budget,
          genres: genres,
          homepage: homepage,
          id: id,
          imdbId: imdbId,
          originalTitle: originalTitle,
          overview: overview,
          popularity: popularity,
          posterPath: posterPath,
          productionCompanies: productionCompanies,
          productionCountries: productionCountries,
          releaseDate: releaseDate,
          revenue: revenue,
          runtime: runtime,
          spokenLanguages: spokenLanguages,
          status: status,
          tagLine: tagLine,
          title: title,
          video: video,
          voteAverage: voteAverage,
          voteCount: voteCount,
        );

  MovieModel.fromJson(Map<String, dynamic> jsonData) {
    adult = jsonData['adult'] ?? false;
    backdropPath = jsonData['backdrop_path'] ?? '';
    belongsToCollection = CollectionModel.fromJson(
        jsonData['belongs_to_collection'] ?? <String, dynamic>{});
    budget = jsonData['budget'] ?? 0;
    genres = jsonData["genres"] != null
        ? GenreModel.fromJsonArray(jsonData["genres"] ?? <String, dynamic>{})
        : <GenreModel>[];
    homepage = jsonData['homepage'] ?? '';
    id = jsonData['id'] ?? 0;
    imdbId = jsonData['imdb_id'] ?? '';
    originalLanguage = jsonData['original_language'] ?? '';
    originalTitle = jsonData['original_title'] ?? '';
    overview = jsonData['overview'] ?? '';
    popularity = jsonData['popularity'] ?? 0.0;
    posterPath = jsonData['poster_path'] ?? '';
    productionCompanies = jsonData["production_companies"] != null
        ? CompanyModel.fromJsonArray(
            jsonData['production_companies'] ?? <String, dynamic>{})
        : <CompanyModel>[];
    productionCountries = jsonData["production_countries"] != null
        ? CountryModel.fromJsonArray(
            jsonData['production_countries'] ?? <String, dynamic>{})
        : <CountryModel>[];
    releaseDate = jsonData['release_date'] ?? '';
    revenue = jsonData['revenue'] ?? 0;
    runtime = jsonData['runtime'] ?? 0;
    spokenLanguages = jsonData["spoken_languages"] != null
        ? LanguageModel.fromJsonArray(
            jsonData['spoken_languages'] ?? <String, dynamic>{})
        : <LanguageModel>[];
    status = jsonData['status'] ?? '';
    tagLine = jsonData['tagline'] ?? '';
    title = jsonData['title'] ?? '';
    video = jsonData['video'] ?? '';
    voteAverage = (jsonData['vote_average'] ?? 0).toDouble();
    voteCount = jsonData['vote_count'] ?? 0.0;
  }
}
