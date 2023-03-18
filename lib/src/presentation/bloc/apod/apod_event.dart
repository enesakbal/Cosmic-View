part of 'apod_bloc.dart';

abstract class APODEvent extends Equatable {
  const APODEvent();

  @override
  List<Object> get props => [];
}

class FetchApodData extends APODEvent {
  final int count;

  const FetchApodData({required this.count});

  @override
  List<Object> get props => [count];
}
