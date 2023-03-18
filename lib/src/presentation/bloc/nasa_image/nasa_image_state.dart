part of 'nasa_image_bloc.dart';

abstract class NasaImageState extends Equatable {
  const NasaImageState();

  @override
  List<Object> get props => [];
}

class NasaImageInitial extends NasaImageState {
  const NasaImageInitial();
}

class NasaImageLoading extends NasaImageState {
  const NasaImageLoading();
}

class NasaImageHasData extends NasaImageState {
  final List<Item> dataList;

  const NasaImageHasData({required this.dataList});

  @override
  List<Object> get props => [dataList];
}

class NasaImageError extends NasaImageState {
  final String message;

  const NasaImageError({required this.message});

  @override
  List<Object> get props => [message];
}
