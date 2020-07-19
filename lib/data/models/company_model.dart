import 'package:flutter_movie_app/domain/entities/company_entity.dart';

class CompanyModel extends CompanyEntity {
  CompanyModel({
    int id,
    String logoPath,
    String name,
    String originCountry,
  }) : super(
          id: id,
          name: name,
          logoPath: logoPath,
          originCountry: originCountry,
        );

  CompanyModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'] ?? 0;
    name = jsonData['name'] ?? '';
    logoPath = jsonData['logo_path'] ?? '';
    originCountry = jsonData['origin_country'] ?? '';
  }

  static List<CompanyModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
          return CompanyModel.fromJson(item);
        })?.toList() ??
        <CompanyModel>[];
  }
}
