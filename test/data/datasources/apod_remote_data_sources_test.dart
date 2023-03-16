import 'dart:io';

import 'package:cosmicview/src/core/constants/url_constants.dart';
import 'package:cosmicview/src/core/network/dio_client.dart';
import 'package:cosmicview/src/data/datasources/remote/apod/apod_remote_data_source.dart';
import 'package:cosmicview/src/data/models/apod_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';

import '../../_helpers/_mocks/mocks.mocks.dart';
import '../../_helpers/json_reader.dart';

void main() {
  dotenv.testLoad(fileInput: File('.env').readAsStringSync());
  late APODRemoteDataSource dataSource;
  late Dio dio;
  late DioClient dioClient;
  late DioAdapter mockDioAdapter;

  late MockAPODRemoteDataSource mockDataSource;

  late List<dynamic> data;

  setUp(() {
    dio = Dio();
    dioClient = DioClient(dio);
    dataSource = APODRemoteDataSourceImpl(dioClient);
    mockDataSource = MockAPODRemoteDataSource();
  });

  group('Remote Data Source (GET DATA) (dummy data) =>', () {
    setUp(() {
      mockDioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = mockDioAdapter;
      dio.options = BaseOptions();
      //* api key ve base urli burada sıfırlamamız gerekiyor.

      //* http_mock_adapter'i kullanabilmek için initilaize etmemiz gerekiyor
      //* bu paket onGet(), onPost() gibi özellikleri kullanmamızı sağlıyor.
      //* dummy bir response yaratıyoruz.

      data = readJson('apod_dummy_data.json') as List<dynamic>;
    });

    test('Should status code 200', () async {
      mockDioAdapter.onGet(
        UrlContants.baseApod,
        (server) => server.reply(200, data),
      );
      //* onGet: Diyelim ki servise gittik ve bize bu sonucu verdi
      final response = await dioClient.get(UrlContants.baseApod);

      expect(response.statusCode, 200);
    });

    test(
        'Data list is succesfully converted to APODModel and data length equals testCount',
        () async {
      const testCount = 15;

      mockDioAdapter.onGet(
          UrlContants.baseApod, (server) => server.reply(200, data));
      //* dio ile istek attığımızda dönecek olan veriyi burada belirledik

      when(await mockDataSource.getAPODData(count: testCount)).thenAnswer(
        (_) => List.generate(
          testCount,
          (index) => const APODModel(),
        ),
      );

      //* burada ise dataSourcedan dönecek değeri kendimiz dummy olarak belirledik.
      final response = await dataSource.getAPODData(count: testCount);

      expect(response.length >= testCount, true);
      expect(response, isA<List<APODModel>>());
    });
  });
}
