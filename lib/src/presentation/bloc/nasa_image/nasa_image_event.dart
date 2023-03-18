part of 'nasa_image_bloc.dart';

abstract class NasaImageEvent extends Equatable {
  const NasaImageEvent();

  @override
  List<Object> get props => [];
}



class FetchNasaImageData extends NasaImageEvent {
  final int count;

  const FetchNasaImageData({required this.count});

  @override
  List<Object> get props => [count];
}
