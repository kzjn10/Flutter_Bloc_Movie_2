import 'package:flutter_movie_app/domain/entities/collection_entity.dart';

class CollectionModel extends CollectionEntity {
  CollectionModel({
    int id,
    String name,
    String posterPath,
    String backdropPath,
  }) : super(
          id: id,
          name: name,
          posterPath: posterPath,
          backdropPath: backdropPath,
        );

  CollectionModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'] ?? 0;
    name = jsonData['name'] ?? '';
    posterPath = jsonData['poster_path'] ?? '';
    backdropPath = jsonData['backdrop_path'] ?? '';
  }
}
