import 'dart:io';

import 'package:cosmicview/src/core/constants/url_constants.dart';
import 'package:cosmicview/src/core/network/apod_client/apod_client.dart';
import 'package:cosmicview/src/core/network/network_exception.dart';
import 'package:cosmicview/src/data/datasources/remote/apod/apod_remote_data_source.dart';
import 'package:cosmicview/src/data/models/apod_model/apod_model.dart';
import 'package:cosmicview/src/data/repositories/apod_repository_impl.dart';
import 'package:cosmicview/src/domain/entities/apod.dart';
import 'package:cosmicview/src/domain/repositories/apod_repository.dart';
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
  //* dummy
  late MockAPODRepository mockApodRepository;
  late DioAdapter mockDioAdapter;

  //* live
  late APODRepository realAPODRepository;
  late APODRemoteDataSource realAPODRemoteDataSource;
  late APODClient client;
  late Dio dio;

  late APODUsecase usecase;

  late List<APOD> dummyData;

  setUp(() {
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    dio = Dio();
  });

  //* live
  group('APOD Repository (FETCH DATA) (real data) =>', () {
    setUp(() {
      client = APODClient(dio);
      realAPODRemoteDataSource = APODRemoteDataSourceImpl(client);
      realAPODRepository = APODRepositoryImpl(realAPODRemoteDataSource);
      usecase = APODUsecase(realAPODRepository);
    });
    test('Should get all data from repository', () async {
      const testCount = 20;
      final response = await usecase.fetchAPODData(count: testCount);

      expect(response.isRight(), true);

      response.fold((failure) {}, (success) {
        expect(success, isA<List<APOD>>());
        expect(success.length, testCount);
      });
    });
    //* error case
    // test('Shouldnt get all data from repository (NO INTERNET CASE)', () async {
    //   const testCount = 20;
    //   final response = await usecase.fetchAPODData(
    //       count: testCount);

    //   expect(response.isLeft(), true);

    //   response.fold((failure) {
    //     expect(
    //         failure,
    //         equals(NetworkExceptions.fromDioError(DioError(
    //           requestOptions: RequestOptions(path: UrlContants.baseApod),
    //           error: failure.message,
    //           type: DioErrorType.other,
    //         ))));
    //   }, (success) {});
    // });
  });

//* dummy
  group('APOD Repository (GET DATA) (dummy data) =>', () {
    setUp(() {
      mockApodRepository = MockAPODRepository();
      usecase = APODUsecase(mockApodRepository);
      mockDioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = mockDioAdapter;

      final data = readJson('apod_dummy_data.json') as List<dynamic>;

      dummyData = data
          .map((e) => APODModel.fromJson(e as Map<String, dynamic>))
          .toList()
          .map((e) => e.toEntity())
          .toList();
    });
    const testCount = 20;
    test('Should get all data from repository (SUCCESS CASE)', () async {
      when(mockApodRepository.fetchAPODData(count: testCount))
          .thenAnswer((_) async {
        return Right(dummyData);
      });

      final response = await usecase.fetchAPODData(count: testCount);

      expect(response.isRight(), true);
      expect(response, equals(Right(dummyData)));
      expect(testCount <= Right(dummyData).value.length, true);
    });

    test('Shouldnt get all data from repository. (ERROR CASE)', () async {
      final error = NetworkExceptions.fromDioError(DioError(
        requestOptions: RequestOptions(path: UrlContants.baseApod),
        error: 'Something went wrong. (TEST ERROR)',
      ));

      when(mockApodRepository.fetchAPODData(count: testCount))
          .thenAnswer((_) async {
        return Left(error);
      });

      final response = await usecase.fetchAPODData(count: testCount);

      expect(response.isLeft(), true);
      expect(response, equals(Left(error)));
    });
  });
}
