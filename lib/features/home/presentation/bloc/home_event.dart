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

class AddProductToHistoryEvent extends HomeEvent {
  final Product product;

  const AddProductToHistoryEvent(this.product);

  @override
  List<Object?> get props => [product];
}

//added for search pagination
class LoadMoreProductsEvent extends HomeEvent {
  const LoadMoreProductsEvent();
}

//ADDED for home page pagination
class LoadMoreRecentScansEvent extends HomeEvent {
  const LoadMoreRecentScansEvent();
}