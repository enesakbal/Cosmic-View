import '../../../../core/constants/url_constants.dart';
import '../../../../core/enums/dio_client_enum.dart';
import '../../../../core/network/dio_client.dart';
import '../../../models/apod_model/apod_model.dart';

abstract class APODRemoteDataSource<T extends DioClient> {
  final T _dioClient;

  APODRemoteDataSource(this._dioClient)
      : assert(_dioClient.clientType == ClientEnum.APOD_CLIENT,
            "CLIENT TYPE MUST BE 'APOD'");

  Future<List<APODModel>> fetchAPODData({required int count});
}

class APODRemoteDataSourceImpl extends APODRemoteDataSource {
  APODRemoteDataSourceImpl(super.dioClient);

  @override
  Future<List<APODModel>> fetchAPODData({required int count}) async {
    try {
      final response = await _dioClient
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
