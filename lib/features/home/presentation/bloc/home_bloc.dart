import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/features/home/data/models/scan_record.dart';
import 'package:food_scan/features/home/data/repositories/scan_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static const int _recentPageSize = 8;

  final ScanRepository _scanRepository;
  List<ScanRecord> _allScans = [];

  DocumentSnapshot<Map<String, dynamic>>? _lastScanDocument;
  bool _hasMoreRecentScans = false;

  late final StreamSubscription<User?> _authSubscription;

  HomeBloc({required ScanRepository scanRepository})
      : _scanRepository = scanRepository,
        super(const HomeInitial()) {
    on<LoadRecentScansEvent>(_onLoadRecentScans);
    on<SearchProductEvent>(_onSearchProduct);
    on<AddProductToHistoryEvent>(_onAddProductToHistory);
    on<LoadMoreRecentScansEvent>(_onLoadMoreRecentScans);

    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((_) {
      add(const LoadRecentScansEvent());
    });
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  Future<void> _onLoadRecentScans(
    LoadRecentScansEvent event,
    Emitter<HomeState> emit,
  ) async {
    final uid = _uid;

    if (uid == null) {
      _allScans = [];
      _lastScanDocument = null;
      _hasMoreRecentScans = false;

      emit(
        const HomeLoaded(
          recentScans: [],
          hasMoreRecentScans: false,
          isLoadingMoreRecentScans: false,
        ),
      );

      // emit(const HomeLoaded(recentScans: []));
      return;
    }
    emit(const HomeLoading());
    try {
      final page = await _scanRepository.getScansPage(uid, limit: _recentPageSize);

      // Debugging logs
      print('FIRST PAGE LOADED: ${page.scans.length}');
      print('HAS MORE: ${page.hasMore}');

      // _allScans = await _scanRepository.getScans(uid);
      _allScans = page.scans;
      _lastScanDocument = page.lastDocument;
      _hasMoreRecentScans = page.hasMore;
      
      // emit(HomeLoaded(recentScans: _allScans));
       emit(
        HomeLoaded(
          recentScans: _allScans,
          query: '',
          hasMoreRecentScans: _hasMoreRecentScans,
          isLoadingMoreRecentScans: false,
        ),
      );
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  void _onSearchProduct(SearchProductEvent event, Emitter<HomeState> emit) {
    final query = event.query.trim();

    if (query.isEmpty) {
      // emit(HomeLoaded(recentScans: _allScans));
      emit(
        HomeLoaded(
          recentScans: _allScans,
          query: '',
          hasMoreRecentScans: _hasMoreRecentScans,
          isLoadingMoreRecentScans: false,
        ),
      );
      return;
    }
    final filtered = _allScans
        .where(
          (scan) => scan.productName.toLowerCase().contains(
            event.query.toLowerCase(),
          ),
        )
        .toList();
    emit(
      HomeLoaded(
        recentScans: filtered,
        query: event.query,
        hasMoreRecentScans: false,
        isLoadingMoreRecentScans: false,
      ),
    );
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
      _allScans = [
        scan,
        ..._allScans.where((s) => s.barcode != scan.barcode),
      ];

      final currentState = state;
      final currentQuery = currentState is HomeLoaded ? currentState.query : '';

      // if (_allScans.length > 20) _allScans = _allScans.sublist(0, 20);
      if (currentQuery.trim().isEmpty) {
        emit(
          HomeLoaded(
            recentScans: _allScans,
            query: '',
            hasMoreRecentScans: _hasMoreRecentScans,
            isLoadingMoreRecentScans: false,
          ),
        );

        return;
      }

      final filtered = _allScans
          .where(
            (scan) => scan.productName.toLowerCase().contains(
                  currentQuery.toLowerCase(),
                ),
          )
          .toList();

      emit(
        HomeLoaded(
          recentScans: filtered,
          query: currentQuery,
          hasMoreRecentScans: false,
          isLoadingMoreRecentScans: false,
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

    emit(
      currentState.copyWith(
        isLoadingMoreRecentScans: true,
      ),
    );

    try {
      final page = await _scanRepository.getScansPage(
        uid,
        limit: _recentPageSize,
        startAfterDocument: _lastScanDocument,
      );

      // Debugging logs
      print('NEXT PAGE LOADED: ${page.scans.length}');
      print('HAS MORE: ${page.hasMore}');
      print('TOTAL SCANS BEFORE ADDING: ${_allScans.length}');

      _lastScanDocument = page.lastDocument;
      _hasMoreRecentScans = page.hasMore;

      final allItems = [
        ..._allScans,
        ...page.scans,
      ];

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
      emit(
        currentState.copyWith(
          isLoadingMoreRecentScans: false,
        ),
      );
    }
  }
}
