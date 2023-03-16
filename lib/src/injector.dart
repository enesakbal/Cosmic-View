import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/enums/dio_client_enum.dart';
import 'core/network/dio_client.dart';
import 'data/datasources/remote/apod/apod_remote_data_source.dart';
import 'data/datasources/remote/nasa_image/nasa_image_remote_data_source.dart';
import 'data/repositories/apod_repository_impl.dart';
import 'data/repositories/nasa_image_repository_impl.dart';
import 'domain/repositories/apod_repository.dart';
import 'domain/repositories/nasa_image_repository.dart';
import 'domain/usecases/apod_usecase.dart';
import 'domain/usecases/nasa_image_usecase.dart';
import 'presentation/bloc/home/home_bloc.dart';

final injector = GetIt.instance;

Future<void> init() async {
  injector

    //* NETWORK
    ..registerLazySingleton(Dio.new)
    ..registerLazySingleton(
        () => DioClient<ClientEnum>(injector(), ClientEnum.APOD_CLIENT))
    ..registerLazySingleton(
        () => DioClient<ClientEnum>(injector(), ClientEnum.NASA_IMAGE_CLIENT))

    //* DATA SOURCES
    ..registerLazySingleton<APODRemoteDataSource<DioClient<ClientEnum>>>(
        () => APODRemoteDataSourceImpl(injector()))
    ..registerLazySingleton<NasaImageRemoteDataSource<DioClient<ClientEnum>>>(
        () => NasaImageRemoteDataSourceImpl(injector()))

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
    ..registerFactory(() => HomeBloc(injector()));
}
