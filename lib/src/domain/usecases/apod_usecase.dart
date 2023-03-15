import 'package:dartz/dartz.dart';

import '../../core/network/network_exception.dart';
import '../entities/apod.dart';
import '../repositories/apod_repository.dart';

class APODUsecase {
  final APODRepository _repository;

  APODUsecase(this._repository);

  Future<Either<NetworkExceptions, List<APOD>>> getAPODData({int? count = 10}) {
    return _repository.getAPODData(count: count!);
  }
}
