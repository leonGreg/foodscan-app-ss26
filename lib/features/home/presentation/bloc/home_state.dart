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

// class HomeLoaded extends HomeState {
//   final List<ScanRecord> recentScans;

//   const HomeLoaded({required this.recentScans});

//   @override
//   List<Object?> get props => [recentScans];
// }

class HomeLoaded extends HomeState {
  final List<ScanRecord> recentScans;
  
  //query is needed to let the Bloc knows when the user is searching. while searching we stop infinite scrolling
  final String query;

  final bool hasMoreRecentScans;
  final bool isLoadingMoreRecentScans;

  const HomeLoaded({
    required this.recentScans,
    this.query = '',
    this.hasMoreRecentScans = false,
    this.isLoadingMoreRecentScans = false,
  });

  bool get isSearchMode => query.trim().isNotEmpty;

  HomeLoaded copyWith({
    List<ScanRecord>? recentScans,
    String? query,
    bool? hasMoreRecentScans,
    bool? isLoadingMoreRecentScans,
  }) {
    return HomeLoaded(
      recentScans: recentScans ?? this.recentScans,
      query: query ?? this.query,
      hasMoreRecentScans: hasMoreRecentScans ?? this.hasMoreRecentScans,
      isLoadingMoreRecentScans:
          isLoadingMoreRecentScans ?? this.isLoadingMoreRecentScans,
    );
  }

  @override
  List<Object?> get props => [
        recentScans,
        query,
        hasMoreRecentScans,
        isLoadingMoreRecentScans,
      ];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
