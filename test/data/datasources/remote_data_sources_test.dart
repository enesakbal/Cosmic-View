// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:cosmicview/src/core/constants/url_constants.dart';
import 'package:cosmicview/src/core/network/dio_client.dart';
import 'package:cosmicview/src/data/datasources/remote/remote_data_source.dart';
import 'package:cosmicview/src/data/models/apod_model/apod_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  dotenv.testLoad(fileInput: File('.env').readAsStringSync());
  late DioClient client;
  late RemoteDataSource dataSource;

  setUp(() {
    client = DioClient(Dio());
    dataSource = RemoteDataSourceImpl(dioClient: client);
  });

  group('Remote Data Source (GET DATA) =>', () {
    test('Should returns tatus code is 200', () async {
      final response = await client.get(UrlContants.baseApod);
      expect(response.statusCode, 200);
    });

    test(
        'Data list is succesfully converted to APODModel and data length equals testCount',
        () async {
      const testCount = 5;
      final response = await dataSource.getAPODData(count: 5);
      expect(response, isA<List<APODModel>>());
      expect(response.length, testCount);
    });


  });
}
