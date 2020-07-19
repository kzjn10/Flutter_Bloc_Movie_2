import 'package:flutter_movie_app/common/configurations/configurations.dart';

class ImageUtils {
  String getImagePath(String imageName) {
    return '${Configurations.imageHost}$imageName';
  }
}
