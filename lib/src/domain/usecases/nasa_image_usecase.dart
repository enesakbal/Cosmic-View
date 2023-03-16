import 'package:dartz/dartz.dart';

import '../../core/network/network_exception.dart';
import '../entities/nasa_image/nasa_image.dart';
import '../repositories/nasa_image_repository.dart';

class NasaImageUsecase {
  final NasaImageRepository _repository;

  NasaImageUsecase(this._repository);

  Future<Either<NetworkExceptions, NasaImage>> fetchNasaImageData({
    required int count,
    String? searchString,
    String? location,
    String? keywords,
    String? startYear,
    String? endYear,
  }) {
    return _repository.fetchNasaImageData(
      count: count,
      searchString: searchString,
      location: location,
      keywords: keywords,
      startYear: startYear,
      endYear: endYear,
    );
  }
}
