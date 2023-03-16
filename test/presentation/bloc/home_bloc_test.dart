import 'package:bloc_test/bloc_test.dart';
import 'package:cosmicview/src/core/constants/url_constants.dart';
import 'package:cosmicview/src/core/network/network_exception.dart';
import 'package:cosmicview/src/data/models/apod_model/apod_model.dart';
import 'package:cosmicview/src/domain/entities/apod.dart';
import 'package:cosmicview/src/domain/usecases/apod_usecase.dart';
import 'package:cosmicview/src/presentation/bloc/home/home_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../_helpers/json_reader.dart';
import 'home_bloc_test.mocks.dart';

@GenerateMocks([APODUsecase])
void main() {
  late MockAPODUsecase usecase;
  late HomeBloc homeBloc;

  late List<APOD> dummyData;

  setUp(() {
    usecase = MockAPODUsecase();
    homeBloc = HomeBloc(usecase);

    final data = readJson('apod_dummy_data.json') as List<dynamic>;

    dummyData = data
        .map((e) => APODModel.fromJson(e as Map<String, dynamic>))
        .toList()
        .map((e) => e.toEntity())
        .toList();
  });

  test('intial state should be empty', () {
    expect(homeBloc.state, const HomeInitial());
  });

  group('Home Bloc', () {
    blocTest<HomeBloc, HomeState>(
      'should emit [loading, has data] when [FetchApodData] get data is successful',
      build: () {
        when(usecase.fetchAPODData(count: 5))
            .thenAnswer((_) async => Right(dummyData));

        return homeBloc;
      },
      act: (bloc) => bloc.add(const FetchApodData(count: 5)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const HomeLoading(),
        HomeHasData(dataList: dummyData),
      ],
      verify: (bloc) {
        verify(usecase.fetchAPODData(count: 5));
      },
    );
    blocTest<HomeBloc, HomeState>(
      'should emit [loading, error] when [FetchApodData] get data is UNsuccessful',
      build: () {
        when(usecase.fetchAPODData(count: 5))
            .thenAnswer((_) async => Left(NetworkExceptions.fromDioError(
                  DioError(
                      requestOptions: RequestOptions(
                        path: UrlContants.baseApod,
                      ),
                      type: DioErrorType.other),
                )));
        return homeBloc;
      },
      act: (bloc) => bloc.add(const FetchApodData(count: 5)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const HomeLoading(),
        const HomeError(message: 'Unexpected error occurred'),
      ],
      verify: (bloc) {
        verify(usecase.fetchAPODData(count: 5));
      },
    );
  });
}
