import 'dart:io';

import 'package:cosmicview/src/core/constants/url_constants.dart';
import 'package:cosmicview/src/core/enums/dio_client_enum.dart';
import 'package:cosmicview/src/core/network/apod_client/apod_client.dart';
import 'package:cosmicview/src/core/network/dio_client.dart';
import 'package:cosmicview/src/data/datasources/remote/nasa_image/nasa_image_remote_data_source.dart';
import 'package:cosmicview/src/data/models/nasa_image_model/collection_model.dart';
import 'package:cosmicview/src/data/models/nasa_image_model/nasa_image_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';

import '../../_helpers/_mocks/mocks.mocks.dart';
import '../../_helpers/json_reader.dart';

void main() {
  dotenv.testLoad(fileInput: File('.env').readAsStringSync());
  late Dio dio;
  late NasaImageClient nasaImageClient;
  late DioAdapter mockDioAdapter;
  late MockNasaImageRemoteDataSource mockNasaImageDataSource;
  late NasaImageRemoteDataSource<BaseClient> realNasaImageDataSource;

  late Map<String, dynamic> dummyData;

  setUp(() {
    dio = Dio();
    nasaImageClient = NasaImageClient(dio);

    dummyData = readJson('nasa_image_dummy_data.json') as Map<String, dynamic>;
  });

//* LIVE
  group('Nasa Image Remote Data source (FETCH DATA) (real data) =>', () {
    setUp(() {
      realNasaImageDataSource = NasaImageRemoteDataSourceImpl(nasaImageClient);
    });

    test('Should status code 200', () async {
      final response = await nasaImageClient.get(UrlContants.searchNasaImage,
          queryParameters: {'keywords': 'cosmos,hubble'});

      expect(response.statusCode, 200);
      expect(response.data, isNotNull);
      expect(response.data, isNotEmpty);
    });

    test('Data converted to NasaImageModel.', () async {
      const testItemCount = 4;
      const searchString = 'cosmos';
      const keywords = 'cosmos';

      final response = await realNasaImageDataSource.fetchNasaImageData(
          count: testItemCount, searchString: searchString, keywords: keywords);

      expect(response, isA<NasaImageModel>());
      expect(response, isNotNull);

      expect(response.collection!.items, isNotEmpty);
      expect(response.collection!.items!.length, testItemCount);
    });
  });

  group('NASA Image Remote Data source (FETCH DATA) (dummy data) =>', () {
    setUp(() {
      mockDioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = mockDioAdapter;
      mockNasaImageDataSource = MockNasaImageRemoteDataSource();
    });

    test('Should status code 200', () async {
      final map = {
        'page_size': 100,
        'q': 'cosmos',
        'keywords': 'cosmos',
        'media_type': 'image',
        'year_start': '1980',
        'year_end': '2023',
      };

      mockDioAdapter.onGet(UrlContants.searchNasaImage,
          (server) => server.reply(200, dummyData));

      final response = await nasaImageClient.get(
        UrlContants.searchNasaImage,
        queryParameters: map,
      );

      expect(response.statusCode, 200);
    });

    test('Data converted to NasaImageModel.', () async {
      const testItemCount = 30;

      final dummyModel = NasaImageModel.fromJson(dummyData);

      mockDioAdapter.onGet(UrlContants.searchNasaImage,
          (server) => server.reply(200, dummyData));

      when(mockNasaImageDataSource.fetchNasaImageData(
              count: testItemCount, searchString: 'data'))
          .thenAnswer(
        (_) => Future(() {
          dummyModel.collection!.items!.take(testItemCount);

          return NasaImageModel(
              collection: CollectionModel(
            href: dummyModel.collection!.href,
            items: dummyModel.collection!.items!.take(testItemCount).toList(),
            links: dummyModel.collection!.links,
            metadata: dummyModel.collection!.metadata,
            version: dummyModel.collection!.version,
          ));
        }),
      );

      final response = await mockNasaImageDataSource.fetchNasaImageData(
          count: testItemCount, searchString: 'data');

      expect(response, isA<NasaImageModel>());
      expect(response, isNotNull);
      expect(response.collection!.items, isNotEmpty);
      expect(response.collection!.items!.length, testItemCount);
    });
  });
}
