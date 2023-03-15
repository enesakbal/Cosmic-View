import 'dart:io';

import 'package:cosmicview/src/core/constants/url_constants.dart';
import 'package:cosmicview/src/core/network/network_exception.dart';
import 'package:cosmicview/src/data/models/apod_model.dart';
import 'package:cosmicview/src/domain/entities/apod.dart';
import 'package:cosmicview/src/domain/usecases/apod_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';

import '../../_helpers/_mocks/mocks.mocks.dart';
import '../../_helpers/json_reader.dart';

void main() {
  late APODUsecase apodUsecase;

  late MockAPODRepository mockApodRepository;
  late DioAdapter mockDioAdapter;

  late Dio dio;

  late List<APOD> dummyData;

  setUp(() {
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    dio = Dio();
    mockApodRepository = MockAPODRepository();
    apodUsecase = APODUsecase(mockApodRepository);
    mockDioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = mockDioAdapter;

    final data = readJson('apod_dummy_data.json') as List<dynamic>;

    dummyData = data
        .map((e) => APODModel.fromJson(e as Map<String, dynamic>))
        .toList()
        .map((e) => e.toEntity())
        .toList();
  });

  group('APOD Repository (GET DATA) (dummy data) =>', () {
    const testCount = 20;
    test('Should get all data from repository', () async {
      when(mockApodRepository.getAPODData(count: testCount))
          .thenAnswer((_) async {
        return Right(dummyData);
      });

      final response = await apodUsecase.getAPODData(count: testCount);

      expect(response.isRight(), true);
      expect(response, equals(Right(dummyData)));
      expect(testCount <= Right(dummyData).value.length, true);
    });

    test('Shouldnt get all data from repository. (ERROR CASE)', () async {
      final error = NetworkExceptions.fromDioError(DioError(
        requestOptions: RequestOptions(path: UrlContants.baseApod),
        error: 'Something went wrong. (TEST ERROR)',
      ));

      when(mockApodRepository.getAPODData(count: testCount))
          .thenAnswer((_) async {
        return Left(error);
      });

      final response = await apodUsecase.getAPODData(count: testCount);

      expect(response.isLeft(), true);
      expect(response, equals(Left(error)));
    });
  });
}
