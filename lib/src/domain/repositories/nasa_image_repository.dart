import 'package:dartz/dartz.dart';

import '../../core/network/network_exception.dart';
import '../entities/nasa_image/nasa_image.dart';

abstract class NasaImageRepository {
  Future<Either<NetworkExceptions, NasaImage>> fetchNasaImageData({
    required int count,
    String? searchString,
    String? location,
    String? keywords,
    String? startYear,
    String? endYear,
  });
}
