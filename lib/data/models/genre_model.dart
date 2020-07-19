import 'package:flutter_movie_app/domain/entities/genre_entity.dart';

class GenreModel extends GenreEntity {
  GenreModel({
    int id,
    String name,
  }) : super(
          id: id,
          name: name,
        );

  GenreModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'] ?? 0;
    name = jsonData['name'] ?? '';
  }

  static List<GenreModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
          return GenreModel.fromJson(item);
        })?.toList() ??
        <GenreModel>[];
  }
}
