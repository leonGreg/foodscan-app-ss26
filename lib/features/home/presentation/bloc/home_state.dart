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
  final List<ScanRecord> recentScans;

  //query is needed to let the Bloc knows when the user is searching. while searching we stop infinite scrolling
  final String query;

  //recentScan pagination
  final bool hasMoreRecentScans;
  final bool isLoadingMoreRecentScans;

  //search pagination
  final bool hasMoreSearchResults;
  final bool isLoadingMoreSearchResults;

  const HomeLoaded({
    required this.recentScans,
    this.query = '',
    this.hasMoreRecentScans = false,
    this.isLoadingMoreRecentScans = false,
    this.hasMoreSearchResults = false,
    this.isLoadingMoreSearchResults = false,
  });

  bool get isSearchMode => query.trim().isNotEmpty;

  bool get isLoadingMoreVisible =>
      isSearchMode ? isLoadingMoreSearchResults : isLoadingMoreRecentScans;

  bool get hasMoreVisible =>
      isSearchMode ? hasMoreSearchResults : hasMoreRecentScans;

  HomeLoaded copyWith({
    List<ScanRecord>? recentScans,
    String? query,
    bool? hasMoreRecentScans,
    bool? isLoadingMoreRecentScans,
    bool? hasMoreSearchResults,
    bool? isLoadingMoreSearchResults,
  }) {
    return HomeLoaded(
      recentScans: recentScans ?? this.recentScans,
      query: query ?? this.query,
      hasMoreRecentScans: hasMoreRecentScans ?? this.hasMoreRecentScans,
      isLoadingMoreRecentScans:
          isLoadingMoreRecentScans ?? this.isLoadingMoreRecentScans,
      hasMoreSearchResults: hasMoreSearchResults ?? this.hasMoreSearchResults,
      isLoadingMoreSearchResults:
          isLoadingMoreSearchResults ?? this.isLoadingMoreSearchResults,
    );
  }

  @override
  List<Object?> get props => [
    recentScans,
    query,
    hasMoreRecentScans,
    isLoadingMoreRecentScans,
    hasMoreSearchResults,
    isLoadingMoreSearchResults,
  ];
}

enum HomeErrorType { networkError }

class HomeError extends HomeState {
  final HomeErrorType type;

  const HomeError({required this.type});

  @override
  List<Object?> get props => [type];
}
