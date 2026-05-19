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
class LoadMoreSearchResultsEvent extends HomeEvent {
  const LoadMoreSearchResultsEvent();
}

//ADDED for home page pagination - fetches data from Firestore
class LoadMoreRecentScansEvent extends HomeEvent {
  const LoadMoreRecentScansEvent();
}

//only switches the displayed state back to the cached recent scans. Does not fetch from Firestore again.
class ShowRecentScansEvent extends HomeEvent {
  const ShowRecentScansEvent();

  @override
  List<Object?> get props => [];
}

//It does not start a new search. It only says: “show the cached _searchScans again when I go back to Search“. It does not fetch from Firestore again.
class ShowSearchResultsEvent extends HomeEvent {
  const ShowSearchResultsEvent();

  @override
  List<Object?> get props => [];
}
