import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/network/network_exception.dart';
import '../../domain/repositories/nasa_image_repository.dart';
import '../datasources/remote/nasa_image/nasa_image_remote_data_source.dart';
import '../models/nasa_image_model/nasa_image_model.dart';

class NasaImageRepositoryImpl implements NasaImageRepository {
  final NasaImageRemoteDataSource _dataSource;

  NasaImageRepositoryImpl(this._dataSource);

  @override
  Future<Either<NetworkExceptions, NasaImageModel>> fetchNasaImageData({
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
      final data;
      return Right(result);
    } on DioError catch (e) {
      return Left(NetworkExceptions.fromDioError(e));
    }
  }
}
