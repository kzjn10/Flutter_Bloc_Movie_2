import 'package:flutter_movie_app/common/configurations/configurations.dart';

class PathUtils {
  static String getImagePath(String imageName, {String width = 'w500'}) {
    return '${Configurations.imageHost}$width$imageName';
  }
}
