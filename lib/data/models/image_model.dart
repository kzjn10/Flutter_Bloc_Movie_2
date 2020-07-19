import 'package:flutter_movie_app/domain/entities/image_entity.dart';

class ImageModel extends ImageEntity {
  ImageModel({
    double aspectRatio,
    String filePath,
    int height,
    String iso6391,
    double voteAverage,
    int voteCount,
    int width,
  }) : super(
          aspectRatio: aspectRatio,
          filePath: filePath,
          height: height,
          iso6391: iso6391,
          voteAverage: voteAverage,
          voteCount: voteCount,
          width: width,
        );

  ImageModel.fromJson(Map<String, dynamic> parsedJson) {
    aspectRatio = parsedJson['aspect_ratio'];
    filePath = parsedJson['file_path'];
    height = parsedJson['height'];
    iso6391 = parsedJson['iso_639_1'];
    voteAverage = parsedJson['vote_average'];
    voteCount = parsedJson['vote_count'];
    width = parsedJson['width'];
  }

  static List<ImageModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
          return ImageModel.fromJson(item);
        })?.toList() ??
        <ImageModel>[];
  }
}
