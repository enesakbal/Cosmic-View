import 'package:dartz/dartz.dart';

import '../../core/network/network_exception.dart';
import '../entities/apod.dart';
import '../repositories/apod_repository.dart';

class APODUsecase {
  final APODRepository _repository;

  APODUsecase(this._repository);

  Future<Either<NetworkExceptions, List<APOD>>> fetchAPODData(
      {required int count}) {
    return _repository.fetchAPODData(count: count);
  }
}
