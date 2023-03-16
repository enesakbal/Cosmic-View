import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/apod.dart';
import '../../../domain/usecases/apod_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final APODUsecase apodUsecase;
  HomeBloc(this.apodUsecase) : super(const HomeInitial()) {
    on<FetchApodData>((event, emit) async {
      emit(const HomeLoading());

      final result = await apodUsecase.getAPODData(count: event.count);

      result.fold((failure) {
        emit(HomeError(message: failure.message));
        return;
      }, (success) {
        emit(HomeHasData(dataList: success));
        return;
      });
    });
  }
}
