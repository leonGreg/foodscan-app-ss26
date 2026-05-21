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
  });
}