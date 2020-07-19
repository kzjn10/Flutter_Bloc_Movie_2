import 'package:flutter_movie_app/domain/entities/image_entity.dart';

class MovieImageEntity {
  int id;
  List<ImageEntity> backdrops;
  List<ImageEntity> posters;

  MovieImageEntity({id, backdrops, posters});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (backdrops != null) {
      data['backdrops'] = backdrops.map((v) => v.toJson()).toList();
    }
    if (posters != null) {
      data['posters'] = posters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
