import '../../../core/constants/url_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exception.dart';
import '../../models/apod_model/apod_model.dart';

abstract class RemoteDataSource {
  Future<List<APODModel>> getAPODData({int? count});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final DioClient dioClient;

  RemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<APODModel>> getAPODData({int? count = 5}) async {
    try {
      final response = await dioClient
          .get(UrlContants.baseApod, queryParameters: {'count': count});
      final data = response.data! as List<dynamic>;
      final dataList = data
          .map((e) => APODModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return dataList;
    } on NetworkExceptions catch (_) {
      rethrow;
    }
  }
}
