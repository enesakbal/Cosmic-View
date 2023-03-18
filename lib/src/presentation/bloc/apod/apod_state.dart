part of 'apod_bloc.dart';

abstract class APODState extends Equatable {
  const APODState();

  @override
  List<Object> get props => [];
}

class APODInitial extends APODState {
  const APODInitial();
}

class APODLoading extends APODState {
  const APODLoading();
}

class APODHasData extends APODState {
  final List<APOD> dataList;

  const APODHasData({required this.dataList});

  @override
  List<Object> get props => [dataList];
}

class APODError extends APODState {
  final String message;

  const APODError({required this.message});

  @override
  List<Object> get props => [message];
}
