import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/enums/dio_client_enum.dart';
import 'core/network/dio_client.dart';
import 'data/datasources/remote/apod/apod_remote_data_source.dart';
import 'data/datasources/remote/nasa_image/nasa_image_remote_data_source.dart';
import 'data/repositories/apod_repository_impl.dart';
import 'domain/repositories/apod_repository.dart';
import 'domain/usecases/apod_usecase.dart';

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
    ..registerLazySingleton<APODRemoteDataSource>(
        () => APODRemoteDataSourceImpl<DioClient<ClientEnum>>(injector()))
    ..registerLazySingleton<NasaImageRemoteDataSource>(
        () => NasaImageRemoteDataSourceImpl<DioClient<ClientEnum>>(injector()))

    //* REPOSITORY
    ..registerLazySingleton<APODRepository>(
        () => APODRepositoryImpl(injector()))

    //* USECASE
    ..registerLazySingleton<APODUsecase>(() => APODUsecase(injector()));
}
