import 'dart:io';

import 'package:cosmicview/src/core/constants/url_constants.dart';
import 'package:cosmicview/src/core/enums/dio_client_enum.dart';
import 'package:cosmicview/src/core/network/dio_client.dart';
import 'package:cosmicview/src/core/network/network_exception.dart';
import 'package:cosmicview/src/data/datasources/remote/nasa_image/nasa_image_remote_data_source.dart';
import 'package:cosmicview/src/data/models/nasa_image_model/nasa_image_model.dart';
import 'package:cosmicview/src/data/repositories/nasa_image_repository_impl.dart';
import 'package:cosmicview/src/domain/entities/nasa_image/nasa_image.dart';
import 'package:cosmicview/src/domain/repositories/nasa_image_repository.dart';
import 'package:cosmicview/src/domain/usecases/nasa_image_usecase.dart';
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
  late MockNasaImageRepository mockNasaImageRepository;
  late DioAdapter mockDioAdapter;

  //* live
  late NasaImageRepository realNasaImageRepository;
  late NasaImageRemoteDataSource realNasaImageRemoteDataSource;
  late DioClient<ClientEnum> client;
  late Dio dio;

  late NasaImageUsecase usecase;

  late NasaImage dummyData;

  setUpAll(() {
    dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    dio = Dio();
  });

//* live
  group('Nasa Image Repository (FETCH DATA) (real data) =>', () {
    setUp(() {
      client = DioClient(dio, ClientEnum.NASA_IMAGE_CLIENT);
      realNasaImageRemoteDataSource = NasaImageRemoteDataSourceImpl(client);
      realNasaImageRepository =
          NasaImageRepositoryImpl(realNasaImageRemoteDataSource);
      usecase = NasaImageUsecase(realNasaImageRepository);
    });
    test('Should get all data from repository', () async {
      const testCount = 20;
      final response = await usecase.fetchNasaImageData(
          count: testCount, searchString: 'cosmos');

      expect(response.isRight(), true);

      response.fold((failure) {}, (success) {
        expect(success, isA<NasaImage>());
        expect(success.collection!.items!.length, testCount);
      });
    });
    //* error case
    //   test('Shouldnt get all data from repository (NO INTERNET CASE)', () async {
    //     const testCount = 20;
    //     final response = await usecase.fetchNasaImageData(
    //         count: testCount, searchString: 'cosmos');

    //     expect(response.isLeft(), true);

    //     response.fold((failure) {
    //       expect(
    //           failure,
    //           equals(NetworkExceptions.fromDioError(DioError(
    //             requestOptions: RequestOptions(path: UrlContants.searchNasaImage),
    //             error: failure.message,
    //             type: DioErrorType.other,
    //           ))));
    //     }, (success) {});
    //   });
  });

//* dummy
  group('Nasa Image Repository (FETCH DATA) (dummy data) =>', () {
    setUp(() {
      mockNasaImageRepository = MockNasaImageRepository();
      usecase = NasaImageUsecase(mockNasaImageRepository);
      mockDioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = mockDioAdapter;
      dio.options = BaseOptions();

      final data =
          readJson('nasa_image_dummy_data.json') as Map<String, dynamic>;

      dummyData = NasaImageModel.fromJson(data).toEntity();
    });

    test('Should get all data from repository (SUSCESS CASE)', () async {
      const testCount = 10;
      const keywords = 'Mars';

      when(mockNasaImageRepository.fetchNasaImageData(
        count: testCount,
        keywords: keywords,
      )).thenAnswer((_) async {
        return Right(dummyData);
      });

      final response = await usecase.fetchNasaImageData(
        count: testCount,
        keywords: keywords,
      );
      expect(response.isRight(), true);
      expect(response, equals(Right(dummyData)));
    });

    test('Shouldnt get all data from repository (ERROR CASE)', () async {
      const testCount = 10;
      const keywords = 'Mars';

      final error = NetworkExceptions.fromDioError(DioError(
        requestOptions: RequestOptions(path: UrlContants.baseApod),
        error: 'Something went wrong. (TEST ERROR)',
      ));

      when(mockNasaImageRepository.fetchNasaImageData(
              count: testCount, keywords: keywords))
          .thenAnswer((_) async {
        return Left(error);
      });

      final response = await usecase.fetchNasaImageData(
        count: testCount,
        keywords: keywords,
      );
      expect(response.isLeft(), true);
      expect(response, equals(Left(error)));
    });
  });
}
