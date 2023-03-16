import 'package:dartz/dartz.dart';

import '../../core/network/network_exception.dart';
import '../../data/models/nasa_image_model/nasa_image_model.dart';

abstract class NasaImageRepository {
  Future<Either<NetworkExceptions, NasaImageModel>> fetchNasaImageData({
    required int count,
    String? searchString,
    String? location,
    String? keywords,
    String? startYear,
    String? endYear,
  });
}
