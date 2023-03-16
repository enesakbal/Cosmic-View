part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchApodData extends HomeEvent {
  final int count;

  const FetchApodData({required this.count});

  @override
  List<Object> get props => [count];
}
