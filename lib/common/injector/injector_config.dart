import 'package:kiwi/kiwi.dart';

import 'package:flutter_movie_app/common/network/network_info.dart';
import 'package:flutter_movie_app/data/datasources/remote/movie_remote_datasource.dart';
import 'package:flutter_movie_app/data/repositories/movie_repository_impl.dart';
import 'package:flutter_movie_app/domain/usecases/movie_usecase.dart';
import 'package:flutter_movie_app/presentation/common_bloc/movie_bloc/movie_bloc.dart';

part 'injector.g.dart';

abstract class Injector {
//  void configure();

//  static KiwiContainer container;
//
//  static void setup() {
//    container = KiwiContainer();
//    _$Injector()._configure();
//  }
//
//  static final Function<T>([String name]) resolve = container.resolve;
//
//  void _configure() {
//    _configureInsuranceModule();
//  }

  void configureInsuranceModule() {
    _configureBlocs();
    _configureUseCases();
    _configureRepositories();
    _configureDataSources();
//    _configureExternal();
    _configureCommon();
//    _configureUtils();
  }

  @Register.factory(MovieBloc)
  void _configureBlocs();

  @Register.factory(MovieUseCase)
  void _configureUseCases();

  @Register.factory(MovieRepositoryImpl)
  void _configureRepositories();

  @Register.factory(MovieRemoteDataSource)
  void _configureDataSources();

//  void _configureExternal();

  @Register.factory(NetworkInfoImpl)
  void _configureCommon();

//  void _configureUtils();
}
