import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/app_clients/app_clients.dart';
import 'data/datasources/remote/apod/apod_remote_data_source.dart';
import 'data/datasources/remote/nasa_image/nasa_image_remote_data_source.dart';
import 'data/repositories/apod_repository_impl.dart';
import 'data/repositories/nasa_image_repository_impl.dart';
import 'domain/repositories/apod_repository.dart';
import 'domain/repositories/nasa_image_repository.dart';
import 'domain/usecases/apod_usecase.dart';
import 'domain/usecases/nasa_image_usecase.dart';
import 'presentation/bloc/apod/apod_bloc.dart';
import 'presentation/bloc/nasa_image/nasa_image_bloc.dart';

final injector = GetIt.instance;

Future<void> init() async {
  injector

    //* NETWORK
    ..registerLazySingleton<APODClient>(() => APODClient(Dio()))
    ..registerLazySingleton<NasaImageClient>(() => NasaImageClient(Dio()))

    //* DATA SOURCES
    ..registerLazySingleton<APODRemoteDataSource>(
        () => APODRemoteDataSourceImpl<APODClient>(injector()))
    ..registerLazySingleton<NasaImageRemoteDataSource>(
        () => NasaImageRemoteDataSourceImpl<NasaImageClient>(injector()))

    //* REPOSITORY
    ..registerLazySingleton<APODRepository>(
        () => APODRepositoryImpl(injector()))
    ..registerLazySingleton<NasaImageRepository>(
        () => NasaImageRepositoryImpl(injector()))

    //* USECASE
    ..registerLazySingleton<APODUsecase>(() => APODUsecase(injector()))
    ..registerLazySingleton<NasaImageUsecase>(
        () => NasaImageUsecase(injector()))

    //* BLOC
    ..registerFactory(() => APODBloc(injector()))
    ..registerFactory(() => NasaImageBloc(injector()));
}
