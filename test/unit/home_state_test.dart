import 'package:flutter_test/flutter_test.dart';
import 'package:food_scan/features/home/presentation/bloc/home_bloc.dart';

void main() {
  group('HomeLoaded computed properties', () {
    test('isSearchMode is false when query is empty', () {
      const state = HomeLoaded(
        recentScans: [],
        query: '',
      );

      expect(state.isSearchMode, isFalse);
    });

    test('isSearchMode is true when query has text', () {
      const state = HomeLoaded(
        recentScans: [],
        query: 'milk',
      );

      expect(state.isSearchMode, isTrue);
    });


    test('recent mode uses recent pagination flags', () {
      const state = HomeLoaded(
        recentScans: [],
        query: '',
        hasMoreRecentScans: true,
        isLoadingMoreRecentScans: true,
        hasMoreSearchResults: false,
        isLoadingMoreSearchResults: false,
      );

      expect(state.isSearchMode, isFalse);
      expect(state.hasMoreVisible, isTrue);
      expect(state.isLoadingMoreVisible, isTrue);
    });

       test('search mode uses search pagination flags', () {
      const state = HomeLoaded(
        recentScans: [],
        query: 'milk',
        hasMoreRecentScans: false,
        isLoadingMoreRecentScans: false,
        hasMoreSearchResults: true,
        isLoadingMoreSearchResults: true,
      );

      expect(state.isSearchMode, isTrue);
      expect(state.hasMoreVisible, isTrue);
      expect(state.isLoadingMoreVisible, isTrue);
    });
  });

  test('copyWith changes only provided values', () {
      const original = HomeLoaded(
        recentScans: [],
        query: '',
        hasMoreRecentScans: true,
        isLoadingMoreRecentScans: false,
        hasMoreSearchResults: false,
        isLoadingMoreSearchResults: false,
      );

      final copy = original.copyWith(
        query: 'apple',
        hasMoreSearchResults: true,
      );

      expect(copy.query, 'apple');
      expect(copy.hasMoreSearchResults, isTrue);

      expect(copy.recentScans, original.recentScans);
      expect(copy.hasMoreRecentScans, original.hasMoreRecentScans);
      expect(
        copy.isLoadingMoreRecentScans,
        original.isLoadingMoreRecentScans,
      );
      expect(
        copy.isLoadingMoreSearchResults,
        original.isLoadingMoreSearchResults,
      );
    });
}