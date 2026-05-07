part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadRecentScansEvent extends HomeEvent {
  const LoadRecentScansEvent();
}

class SearchProductEvent extends HomeEvent {
  final String query;

  const SearchProductEvent(this.query);

  @override
  List<Object?> get props => [query];
}

