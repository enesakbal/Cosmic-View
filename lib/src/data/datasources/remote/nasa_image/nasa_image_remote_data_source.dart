import '../../../../core/constants/url_constants.dart';
import '../../../../core/enums/dio_client_enum.dart';
import '../../../../core/network/app_clients/app_clients.dart';
import '../../../../core/network/dio_client.dart';
import '../../../models/nasa_image_model/nasa_image_model.dart';

abstract class NasaImageRemoteDataSource<T extends BaseClient> {
  final NasaImageClient _baseClient;

  NasaImageRemoteDataSource(this._baseClient)
      : assert(
          _baseClient.clientType == ClientEnum.NASA_IMAGE_CLIENT,
          "CLIENT TYPE MUST BE 'NASA_IMAGE_CLIENT'",
        );

  Future<NasaImageModel> fetchNasaImageData({
    required int count,
    String? searchString,
    String? location,
    String? keywords,
    String? startYear,
    String? endYear,
  });
}

class NasaImageRemoteDataSourceImpl<T extends BaseClient> extends NasaImageRemoteDataSource<T> {
  NasaImageRemoteDataSourceImpl(super._baseClient);

  @override
  Future<NasaImageModel> fetchNasaImageData({
    required int count,
    String? searchString,
    String? location,
    String? keywords,
    String? startYear,
    String? endYear,
  }) async {
    // assert(
    //   searchString != null || keywords != null,
    //   'SEARCHSTRING OR KEYWORDS MUST BE NOT NULL',
    // );

    // assert(
    //   (searchString != null && searchString.isNotEmpty) ||
    //       (keywords != null && keywords.isNotEmpty),
    //   'SEARCHSTRING OR KEYWORDS MUST BE NOT NULL',
    // );
    try {
      final map = {
        'page_size': count,
        'q': searchString,
        'location': location,
        'keywords': keywords,
        'media_type': 'image',
      };

      if (startYear != null) {
        map['year_start'] = startYear;
      }

      if (endYear != null) {
        map['year_end'] = endYear;
      }

      final response = await _baseClient.get(
        UrlContants.searchNasaImage,
        queryParameters: map,
      );
      final data =
          NasaImageModel.fromJson(response.data! as Map<String, dynamic>);

      return data;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
