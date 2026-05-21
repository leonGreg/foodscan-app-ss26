import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/features/home/data/models/scan_record.dart';
import 'package:food_scan/features/home/data/repositories/scan_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

typedef CurrentUidProvider = String? Function();

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static const int _recentPageSize = 8;
  static const int _searchPageSize = 8;

  final ScanRepository _scanRepository;
  final CurrentUidProvider _currentUidProvider;
  final Stream<User?> _authStateChanges;

  List<ScanRecord> _allScans = [];
  List<ScanRecord> _searchScans = [];

  DocumentSnapshot<Map<String, dynamic>>? _lastScanDocument;
  DocumentSnapshot<Map<String, dynamic>>? _lastSearchDocument;

  bool _hasMoreRecentScans = false;
  bool _hasMoreSearchResults = false;

  String _currentSearchQuery = '';

  late final StreamSubscription<User?> _authSubscription;

  HomeBloc({
    required ScanRepository scanRepository,
    CurrentUidProvider? currentUidProvider,
    Stream<User?>? authStateChanges,
  }) : _scanRepository = scanRepository,
       _currentUidProvider =
           currentUidProvider ?? (() => FirebaseAuth.instance.currentUser?.uid),
       _authStateChanges =
           authStateChanges ?? FirebaseAuth.instance.authStateChanges(),
       super(const HomeInitial()) {
    on<LoadRecentScansEvent>(_onLoadRecentScans);
    on<SearchProductEvent>(_onSearchProduct);
    on<AddProductToHistoryEvent>(_onAddProductToHistory);
    on<LoadMoreRecentScansEvent>(_onLoadMoreRecentScans);
    on<LoadMoreSearchResultsEvent>(_onLoadMoreSearchResults);
    on<ShowRecentScansEvent>(_onShowRecentScans);
    on<ShowSearchResultsEvent>(_onShowSearchResults);

    // _authSubscription = FirebaseAuth.instance.authStateChanges().listen((_) {
    //   add(const LoadRecentScansEvent());
    // });

    _authSubscription = _authStateChanges.listen((_) {
      add(const LoadRecentScansEvent());
    });
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  // String? get _uid => FirebaseAuth.instance.currentUser?.uid;
  String? get _uid => _currentUidProvider();

  Future<void> _onLoadRecentScans(
    LoadRecentScansEvent event,
    Emitter<HomeState> emit,
  ) async {
    final uid = _uid;

    if (uid == null) {
      _allScans = [];
      _searchScans = [];
      _lastScanDocument = null;
      _lastSearchDocument = null;
      _hasMoreRecentScans = false;
      _hasMoreSearchResults = false;
      _currentSearchQuery = '';

      emit(
        const HomeLoaded(
          recentScans: [],
          hasMoreRecentScans: false,
          isLoadingMoreRecentScans: false,
        ),
      );

      return;
    }
    emit(const HomeLoading());
    try {
      final page = await _scanRepository.getScansPage(
        uid,
        limit: _recentPageSize,
      );

      _allScans = page.scans;
      _lastScanDocument = page.lastDocument;
      _hasMoreRecentScans = page.hasMore;

      _searchScans = [];
      _lastSearchDocument = null;
      _hasMoreSearchResults = false;
      _currentSearchQuery = '';

      emit(
        HomeLoaded(
          recentScans: _allScans,
          query: '',
          hasMoreRecentScans: _hasMoreRecentScans,
          isLoadingMoreRecentScans: false,
          hasMoreSearchResults: false,
          isLoadingMoreSearchResults: false,
        ),
      );
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onSearchProduct(
    SearchProductEvent event,
    Emitter<HomeState> emit,
  ) async {
    final uid = _uid;
    final query = event.query.trim();

    if (uid == null) return;

    if (query.isEmpty) {
      _searchScans = [];
      _lastSearchDocument = null;
      _hasMoreSearchResults = false;
      _currentSearchQuery = '';

      emit(
        HomeLoaded(
          recentScans: _allScans,
          query: '',
          hasMoreRecentScans: _hasMoreRecentScans,
          isLoadingMoreRecentScans: false,
          hasMoreSearchResults: false,
          isLoadingMoreSearchResults: false,
        ),
      );

      return;
    }

    _currentSearchQuery = query;
    _searchScans = [];
    _lastSearchDocument = null;
    _hasMoreSearchResults = false;

    final currentState = state;

    if (currentState is HomeLoaded) {
      emit(
        currentState.copyWith(
          recentScans: [],
          query: query,
          hasMoreSearchResults: false,
          isLoadingMoreSearchResults: true,
        ),
      );
    } else {
      emit(
        HomeLoaded(
          recentScans: const [],
          query: query,
          isLoadingMoreSearchResults: true,
        ),
      );
    }

    try {
      final page = await _scanRepository.searchScansPage(
        uid,
        queryText: query,
        limit: _searchPageSize,
      );

      if (_currentSearchQuery != query) return;

      _searchScans = page.scans;
      _lastSearchDocument = page.lastDocument;
      _hasMoreSearchResults = page.hasMore;

      emit(
        HomeLoaded(
          recentScans: _searchScans,
          query: query,
          hasMoreRecentScans: false,
          isLoadingMoreRecentScans: false,
          hasMoreSearchResults: _hasMoreSearchResults,
          isLoadingMoreSearchResults: false,
        ),
      );
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onAddProductToHistory(
    AddProductToHistoryEvent event,
    Emitter<HomeState> emit,
  ) async {
    final uid = _uid;
    if (uid == null) return;

    final scan = ScanRecord.fromProduct(event.product);
    try {
      await _scanRepository.saveScan(uid, scan);
      _allScans = [scan, ..._allScans.where((s) => s.barcode != scan.barcode)];

      final currentState = state;
      // final currentQuery = currentState is HomeLoaded ? currentState.query : '';

      if (currentState is HomeLoaded && currentState.isSearchMode) {
        //add(SearchProductEvent(currentState.query));
        //return;

        final query = currentState.query.toLowerCase();

        final matchSearch =
            scan.productName.toLowerCase().contains(query) ||
            scan.barcode.toLowerCase().contains(query);

        if (matchSearch) {
          _searchScans = [
            scan,
            ..._searchScans.where((s) => s.barcode != scan.barcode),
          ];
        }

        emit(
          currentState.copyWith(
            recentScans: _searchScans,
            hasMoreSearchResults: _hasMoreSearchResults,
            isLoadingMoreSearchResults: false,
          ),
        );

        return;
      }

      emit(
        HomeLoaded(
          recentScans: _allScans,
          query: '',
          hasMoreRecentScans: _hasMoreRecentScans,
          isLoadingMoreRecentScans: false,
          hasMoreSearchResults: false,
          isLoadingMoreSearchResults: false,
        ),
      );
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onLoadMoreRecentScans(
    LoadMoreRecentScansEvent event,
    Emitter<HomeState> emit,
  ) async {
    final uid = _uid;
    final currentState = state;

    if (uid == null) return;
    if (currentState is! HomeLoaded) return;
    if (currentState.isSearchMode) return;
    if (currentState.isLoadingMoreRecentScans) return;
    if (!currentState.hasMoreRecentScans) return;

    emit(currentState.copyWith(isLoadingMoreRecentScans: true));

    try {
      final page = await _scanRepository.getScansPage(
        uid,
        limit: _recentPageSize,
        startAfterDocument: _lastScanDocument,
      );

      _lastScanDocument = page.lastDocument;
      _hasMoreRecentScans = page.hasMore;

      final allItems = [..._allScans, ...page.scans];

      final uniqueItems = <String, ScanRecord>{};

      for (final scan in allItems) {
        uniqueItems[scan.barcode] = scan;
      }

      _allScans = uniqueItems.values.toList();

      emit(
        currentState.copyWith(
          recentScans: _allScans,
          hasMoreRecentScans: _hasMoreRecentScans,
          isLoadingMoreRecentScans: false,
        ),
      );
    } catch (e) {
      emit(currentState.copyWith(isLoadingMoreRecentScans: false));
    }
  }

  Future<void> _onLoadMoreSearchResults(
    LoadMoreSearchResultsEvent event,
    Emitter<HomeState> emit,
  ) async {
    final uid = _uid;
    final currentState = state;

    if (uid == null) return;
    if (currentState is! HomeLoaded) return;
    if (!currentState.isSearchMode) return;
    if (currentState.isLoadingMoreSearchResults) return;
    if (!currentState.hasMoreSearchResults) return;

    final query = _currentSearchQuery;

    emit(currentState.copyWith(isLoadingMoreSearchResults: true));

    try {
      final page = await _scanRepository.searchScansPage(
        uid,
        queryText: _currentSearchQuery,
        limit: _searchPageSize,
        startAfterDocument: _lastSearchDocument,
      );

      if (_currentSearchQuery != query) return;

      _lastSearchDocument = page.lastDocument;
      _hasMoreSearchResults = page.hasMore;

      final allItems = [..._searchScans, ...page.scans];

      final uniqueItems = <String, ScanRecord>{};

      for (final scan in allItems) {
        uniqueItems[scan.barcode] = scan;
      }

      _searchScans = uniqueItems.values.toList();

      emit(
        currentState.copyWith(
          recentScans: _searchScans,
          hasMoreSearchResults: _hasMoreSearchResults,
          isLoadingMoreSearchResults: false,
        ),
      );
    } catch (e) {
      emit(currentState.copyWith(isLoadingMoreSearchResults: false));
    }
  }

  void _onShowRecentScans(ShowRecentScansEvent event, Emitter<HomeState> emit) {
    emit(
      HomeLoaded(
        recentScans: _allScans,
        query: '',
        hasMoreRecentScans: _hasMoreRecentScans,
        isLoadingMoreRecentScans: false,
        hasMoreSearchResults: _hasMoreSearchResults,
        isLoadingMoreSearchResults: false,
      ),
    );
  }

  void _onShowSearchResults(
    ShowSearchResultsEvent event,
    Emitter<HomeState> emit,
  ) {
    if (_currentSearchQuery.isEmpty) {
      emit(
        HomeLoaded(
          recentScans: const [],
          query: '',
          hasMoreRecentScans: _hasMoreRecentScans,
          isLoadingMoreRecentScans: false,
          hasMoreSearchResults: false,
          isLoadingMoreSearchResults: false,
        ),
      );

      return;
    }

    emit(
      HomeLoaded(
        recentScans: _searchScans,
        query: _currentSearchQuery,
        hasMoreRecentScans: false,
        isLoadingMoreRecentScans: false,
        hasMoreSearchResults: _hasMoreSearchResults,
        isLoadingMoreSearchResults: false,
      ),
    );
  }
}
