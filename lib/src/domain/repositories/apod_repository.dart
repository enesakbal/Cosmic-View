import 'package:dartz/dartz.dart';

import '../../core/network/app_clients/app_clients.dart';
import '../../core/network/dio_client.dart';
import '../../core/network/network_exception.dart';
import '../entities/apod.dart';

abstract class APODRepository {
  Future<Either<NetworkExceptions, List<APOD>>> fetchAPODData(
      {required int count});
}
