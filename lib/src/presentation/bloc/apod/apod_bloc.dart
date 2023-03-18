import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/apod.dart';
import '../../../domain/usecases/apod_usecase.dart';

part 'apod_event.dart';
part 'apod_state.dart';

class APODBloc extends Bloc<APODEvent, APODState> {
  bool more = true;
  final APODUsecase _apodUsecase;
  APODBloc(this._apodUsecase) : super(const APODInitial()) {
    on<FetchApodData>((event, emit) async {
      emit(const APODLoading());

      final result = await _apodUsecase.fetchAPODData(count: event.count);

      result.fold((failure) {
        emit(APODError(message: failure.message));
        return;
      }, (success) {
        more = false;
        emit(APODHasData(dataList: success));
        return;
      });
    });
  }
}
