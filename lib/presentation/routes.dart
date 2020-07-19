import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_movie_app/common/constants/router_constants.dart';
import 'package:flutter_movie_app/presentation/journey/detail/move_detail_sccreen.dart';
import 'package:flutter_movie_app/presentation/journey/detail/movie_detail_constants.dart';
import 'package:flutter_movie_app/presentation/journey/home/home_screen.dart';
import 'package:flutter_movie_app/presentation/journey/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.initial:
        return PageRouteBuilder(pageBuilder: (_, a1, a2) => SplashScreen());
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RouteName.movieDetailScreen:
        final MovieDetailArguments arguments = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => MovieDetailScreen(
            movieId: arguments.movieId,
            coverPath: arguments.coverPath,
            title: arguments.title,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static Map<String, WidgetBuilder> _getCombinedRoutes() => {};

  static Map<String, WidgetBuilder> getAll() => _getCombinedRoutes();
}
