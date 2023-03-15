import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/network/network_exception.dart';
import '../../domain/entities/apod.dart';
import '../../domain/repositories/apod_repository.dart';
import '../datasources/remote/apod/apod_remote_data_source.dart';

class APODRepositoryImpl implements APODRepository {
  APODRemoteDataSource dataSource;

  APODRepositoryImpl(this.dataSource);

  @override
  Future<Either<NetworkExceptions, List<APOD>>> getAPODData(
      {required int count}) async {
    try {
      final result = await dataSource.getAPODData(count: count);

      final data = result.map((e) => e.toEntity()).toList();

      return Right(data);
    } on DioError catch (e) {
      return Left(NetworkExceptions.fromDioError(e));
    }
  }
}
