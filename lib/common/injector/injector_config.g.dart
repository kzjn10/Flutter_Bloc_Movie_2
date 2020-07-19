// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector_config.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$InjectorConfig extends InjectorConfig {
  void _configureBlocs() {
    KiwiContainer()
      ..registerSingleton((c) => LanguageBloc())
      ..registerFactory((c) => MovieBloc(movieUseCase: c<MovieUseCase>()))
      ..registerFactory((c) => TimerBloc(ticker: c<Ticker>()));
  }

  void _configureUseCases() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory(
        (c) => MovieUseCase(movieRepository: c<MovieRepositoryImpl>()));
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

  void _configureExternal() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => MovieClient());
  }

  void _configureCommon() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => NetworkInfoImpl());
  }

  void _configureUtils() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => Ticker());
  }
}
