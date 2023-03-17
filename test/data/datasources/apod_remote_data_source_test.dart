import 'dart:io';

import 'package:cosmicview/src/core/constants/url_constants.dart';
import 'package:cosmicview/src/core/network/apod_client/apod_client.dart';
import 'package:cosmicview/src/core/network/dio_client.dart';
import 'package:cosmicview/src/data/datasources/remote/apod/apod_remote_data_source.dart';
import 'package:cosmicview/src/data/models/apod_model/apod_model.dart';
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
  late APODClient apodClient;
  late DioAdapter mockDioAdapter;
  late MockAPODRemoteDataSource mockAPODDataSource;
  late APODRemoteDataSource<BaseClient> realAPODRemoteDataSource;

  late List<dynamic> dummyData;

  setUp(() {
    dio = Dio();
    apodClient = APODClient(dio);

    dummyData = readJson('apod_dummy_data.json') as List<dynamic>;
  });

//* LIVE
  group('APOD Remote Data Source (Fetch DATA) (real data) =>', () {
    setUp(() {
      realAPODRemoteDataSource = APODRemoteDataSourceImpl(apodClient);
    });
    test('Should status code 200', () async {
      final response = await apodClient.get(UrlContants.baseApod);

      expect(response.statusCode, 200);
    });

    test(
        'Data list is succesfully converted to APODModel and data length equals testCount',
        () async {
      const testCount = 10;

      final response =
          await realAPODRemoteDataSource.fetchAPODData(count: testCount);

      expect(response.length == testCount, true);
      expect(response, isA<List<APODModel>>());
    });
  });

//* DUMMY
  group('APOD Remote Data Source (Fetch DATA) (dummy data) =>', () {
    setUp(
      () {
        mockDioAdapter = DioAdapter(dio: dio);
        dio.httpClientAdapter = mockDioAdapter;
        mockAPODDataSource = MockAPODRemoteDataSource();
      },
    );
    test('Should status code 200', () async {
      mockDioAdapter.onGet(
        UrlContants.baseApod,
        (server) => server.reply(200, dummyData),
      );
      //* onGet: Diyelim ki servise gittik ve bize bu sonucu verdi
      final response = await apodClient.get(UrlContants.baseApod);

      expect(response.statusCode, 200);
    });

    test(
        'Data list is succesfully converted to APODModel and data length equals testCount',
        () async {
      const testCount = 10;

      mockDioAdapter.onGet(
          UrlContants.baseApod, (server) => server.reply(200, dummyData));
      //* dio ile istek attığımızda dönecek olan veriyi burada belirledik

      when(mockAPODDataSource.fetchAPODData(count: testCount))
          .thenAnswer((_) => Future(
                () => List.generate(
                  dummyData.length,
                  (index) => APODModel.fromJson(
                    dummyData[index] as Map<String, dynamic>,
                  ),
                ),
              ));

      //* burada ise dataSourcedan dönecek değeri kendimiz dummy olarak belirledik.
      final response = await mockAPODDataSource.fetchAPODData(count: testCount);

      verify(await mockAPODDataSource.fetchAPODData(count: testCount));

      expect(response.length >= testCount, true);
      expect(response, isA<List<APODModel>>());
    });
  });
}
