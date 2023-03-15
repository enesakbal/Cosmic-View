import 'package:dartz/dartz.dart';

import '../../core/network/network_exception.dart';
import '../entities/apod.dart';

abstract class APODRepository {
  Future<Either<NetworkExceptions, List<APOD>>> getAPODData({required int count});
}
