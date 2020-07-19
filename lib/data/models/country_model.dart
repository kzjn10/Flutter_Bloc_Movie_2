import 'package:flutter_movie_app/domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  CountryModel({
    String id,
    String name,
  }) : super(
          id: id,
          name: name,
        );

  CountryModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['iso_3166_1'] ?? '';
    name = jsonData['name'] ?? '';
  }

  static List<CountryModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
          return CountryModel.fromJson(item);
        })?.toList() ??
        <CountryModel>[];
  }
}
