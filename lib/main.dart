import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bloc/bloc.dart';

import 'package:flutter_movie_app/presentation/app.dart';
import 'package:flutter_movie_app/common/injector/injector_config.dart';
import 'package:flutter_movie_app/common/configurations/configurations.dart';
import 'package:flutter_movie_app/presentation/common_bloc/supervisor_bloc/supervisor_bloc.dart';

import 'env.dart' as config;

Future<void> main() async {
  InjectorConfig.setup();
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await Configurations().setConfigurationValues(config.environment);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(
            MovieApp(),
          ));
}
