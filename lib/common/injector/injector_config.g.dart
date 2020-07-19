// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector_config.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$InjectorConfig extends InjectorConfig {
  void _configureBlocs() {
    final KiwiContainer container = KiwiContainer();
    container
        .registerFactory((c) => MovieBloc(movieUseCase: c<MovieUseCase>()));
  }

  void _configureUseCases() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory(
        (c) => MovieUseCase(movieRepository: c<MovieRepository>()));
  }

  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) =>
        MovieRepositoryImpl(c<NetworkInfoImpl>(), c<MovieRemoteDataSource>()));
  }

  void _configureDataSources() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory(
        (c) => MovieRemoteDataSource(movieClient: c<MovieClient>()));
  }

  void _configureCommon() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => NetworkInfoImpl());
  }
}
