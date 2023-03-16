import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/enums/dio_client_enum.dart';
import '../../core/network/network_exception.dart';
import '../../domain/entities/nasa_image/nasa_image.dart';
import '../../domain/repositories/nasa_image_repository.dart';
import '../datasources/remote/nasa_image/nasa_image_remote_data_source.dart';

class NasaImageRepositoryImpl implements NasaImageRepository {
  final NasaImageRemoteDataSource _dataSource;

  NasaImageRepositoryImpl(this._dataSource);

  @override
  Future<Either<NetworkExceptions, NasaImage>> fetchNasaImageData({
    required int count,
    String? searchString,
    String? location,
    String? keywords,
    String? startYear,
    String? endYear,
  }) async {
    try {
      final result = await _dataSource.fetchNasaImageData(
        count: count,
        searchString: searchString,
        location: location,
        keywords: keywords,
        startYear: startYear,
        endYear: endYear,
      );
      final data = result.toEntity();
      return Right(data);
    } on DioError catch (e) {
      return Left(NetworkExceptions.fromDioError(e));
    }
  }
}
