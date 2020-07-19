import 'package:kiwi/kiwi.dart';

import 'package:flutter_movie_app/common/network/network_info.dart';
import 'package:flutter_movie_app/data/datasources/remote/movie_remote_datasource.dart';
import 'package:flutter_movie_app/data/repositories/movie_repository_impl.dart';
import 'package:flutter_movie_app/domain/usecases/movie_usecase.dart';
import 'package:flutter_movie_app/presentation/common_bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_movie_app/common/network/http/movie_client.dart';
import 'package:flutter_movie_app/presentation/common_bloc/language_bloc/language_bloc.dart';
import 'package:flutter_movie_app/presentation/common_bloc/timer_bloc/ticker.dart';
import 'package:flutter_movie_app/presentation/common_bloc/timer_bloc/timer_bloc.dart';

part 'injector_config.g.dart';

abstract class InjectorConfig {
  static KiwiContainer container;

  static void setup() {
    container = KiwiContainer();
    final injector = _$InjectorConfig();
    // ignore: cascade_invocations
    injector._configure();
  }

  // ignore: type_annotate_public_apis
  static final resolve = container.resolve;

  void _configure() {
    _configureInsuranceModule();
  }

  void _configureInsuranceModule() {
    _configureBlocs();
    _configureUseCases();
    _configureRepositories();
    _configureDataSources();
    _configureExternal();
    _configureCommon();
    _configureUtils();
  }

  @Register.factory(MovieBloc)
  @Register.factory(TimerBloc)
  @Register.singleton(LanguageBloc)
  void _configureBlocs();

  @Register.factory(MovieUseCase)
  void _configureUseCases();

  @Register.factory(MovieRepositoryImpl)
  void _configureRepositories();

  @Register.factory(MovieRemoteDataSource)
  void _configureDataSources();

  @Register.singleton(MovieClient)
  void _configureExternal();

  @Register.factory(NetworkInfoImpl)
  void _configureCommon();

  @Register.singleton(Ticker)
  void _configureUtils();
}
