part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Product> recentScans;

  const HomeLoaded({required this.recentScans});

  @override
  List<Object?> get props => [recentScans];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
