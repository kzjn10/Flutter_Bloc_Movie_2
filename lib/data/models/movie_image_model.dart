import 'package:flutter_movie_app/data/models/image_model.dart';
import 'package:flutter_movie_app/domain/entities/movie_image_entity.dart';

class MovieImageModel extends MovieImageEntity {
  MovieImageModel({
    int id,
    List<ImageModel> backdrops,
    List<ImageModel> posters,
  }) : super(
          id: id,
          backdrops: backdrops,
          posters: posters,
        );

  MovieImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    if (json['posters'] != null) {
      posters = <ImageModel>[];
      json['posters'].forEach((v) {
        posters.add(ImageModel.fromJson(v));
      });
    }

    if (json['backdrops'] != null) {
      backdrops = <ImageModel>[];
      json['backdrops'].forEach((v) {
        backdrops.add(ImageModel.fromJson(v));
      });
    }
  }
}
