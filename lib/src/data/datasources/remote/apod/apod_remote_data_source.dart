import '../../../../core/constants/url_constants.dart';
import '../../../../core/enums/dio_client_enum.dart';
import '../../../../core/network/dio_client.dart';
import '../../../models/apod_model/apod_model.dart';

abstract class APODRemoteDataSource<T extends BaseClient> {
  final T _baseClient;

  APODRemoteDataSource(this._baseClient)
      : assert(_baseClient.clientType == ClientEnum.APOD_CLIENT,
            "CLIENT TYPE MUST BE 'APOD'");

  Future<List<APODModel>> fetchAPODData({required int count});
}

class APODRemoteDataSourceImpl<T extends BaseClient> extends APODRemoteDataSource<T> {
  APODRemoteDataSourceImpl(super._baseClient);

  @override
  Future<List<APODModel>> fetchAPODData({required int count}) async {
    try {
      final response = await _baseClient
          .get(UrlContants.baseApod,
          queryParameters: {'count': count});
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
