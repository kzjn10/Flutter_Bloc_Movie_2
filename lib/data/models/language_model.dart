import 'package:flutter_movie_app/domain/entities/language_entity.dart';

class LanguageModel extends LanguageEntity {
  LanguageModel({
    String iso6391,
    String name,
  }) : super(
          name: name,
          iso6391: iso6391,
        );

  LanguageModel.fromJson(Map<String, dynamic> jsonData) {
    iso6391 = jsonData['iso_639_1'];
    name = jsonData['name'];
  }

  static List<LanguageModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
          return LanguageModel.fromJson(item);
        })?.toList() ??
        <LanguageModel>[];
  }
}
