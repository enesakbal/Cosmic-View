// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import '../../../../core/constants/url_constants.dart';
import '../../../../core/enums/dio_client_enum.dart';
import '../../../../core/network/dio_client.dart';
import '../../../models/apod_model.dart';

abstract class APODRemoteDataSource {
  Future<List<APODModel>> fetchAPODData({required int count});
}

class APODRemoteDataSourceImpl<T extends DioClient>
    extends APODRemoteDataSource {
  final T _dioClient;

  APODRemoteDataSourceImpl(this._dioClient)
      : assert(_dioClient.clientType == ClientEnum.APOD_CLIENT,
            "CLIENT TYPE MUST BE 'APOD'");

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
