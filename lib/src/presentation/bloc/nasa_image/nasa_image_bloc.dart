import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/nasa_image/item.dart';
import '../../../domain/usecases/nasa_image_usecase.dart';

part 'nasa_image_event.dart';
part 'nasa_image_state.dart';

class NasaImageBloc extends Bloc<NasaImageEvent, NasaImageState> {
  bool more = true;
  final NasaImageUsecase _nasaImageUsecase;
  NasaImageBloc(this._nasaImageUsecase) : super(const NasaImageInitial()) {
    on<FetchNasaImageData>((event, emit) async {
      emit(const NasaImageLoading());

      final randomYear = Random().nextInt(123) + 1900;
      final result = await _nasaImageUsecase.fetchNasaImageData(
        count: event.count,
        searchString: 'nebula',
        startYear: randomYear.toString(),
      );

      result.fold((failure) => emit(NasaImageError(message: failure.message)),
          (data) {
        data.collection!.items!.shuffle(
          Random(randomYear),
        );
        emit(
          NasaImageHasData(dataList: data.collection!.items!),
        );
        return;
      });
    });
  }
}
