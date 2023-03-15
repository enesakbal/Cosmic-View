import '../../../../core/constants/url_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../models/apod_model.dart';

abstract class APODRemoteDataSource {
  Future<List<APODModel>> getAPODData({required int count});
}

class APODRemoteDataSourceImpl implements APODRemoteDataSource {
  final DioClient dioClient;

  APODRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<APODModel>> getAPODData({required int count}) async {
    try {
      final response = await dioClient
          .get(UrlContants.baseApod, queryParameters: {'count': count});
      final data = response.data! as List<dynamic>;
      final dataList = data
          .map((e) => APODModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return dataList;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
