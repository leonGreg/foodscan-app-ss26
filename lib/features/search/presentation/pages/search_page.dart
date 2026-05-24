import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/config/constants/nutrition.dart';
import 'package:food_scan/features/home/data/models/scan_record.dart';
import 'package:food_scan/features/home/presentation/bloc/home_bloc.dart';
import 'package:food_scan/features/home/presentation/widgets/recent_scan_card.dart';
import 'package:food_scan/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(children: [_SearchContent(), _SearchBarOverlay()]),
    );
  }
}

class _SearchContent extends StatelessWidget {
  const _SearchContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SearchHeader(),
        const SizedBox(height: AppDimensions.paddingXLarge + 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
            ),
            child: const _SearchResultsList(),
          ),
        ),
      ],
    );
  }
}

class _SearchHeader extends StatelessWidget {
  const _SearchHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: AppDimensions.appBarExpandedHeight,
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(AppColors.primaryGreen)),
      padding: const EdgeInsets.only(
        top: AppDimensions.appBarTopPadding,
        left: AppDimensions.paddingLarge,
        right: AppDimensions.paddingLarge,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.searchTitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingXSmall),
          Text(
            l10n.searchSubtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBarOverlay extends StatelessWidget {
  const _SearchBarOverlay();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Positioned(
      top: AppDimensions.searchBarTopOffset,
      left: AppDimensions.paddingLarge,
      right: AppDimensions.paddingLarge,
      child: _CustomSearchBar(hint: l10n.searchHint, isDarkMode: isDarkMode),
    );
  }
}

class _CustomSearchBar extends StatefulWidget {
  final String hint;
  final bool isDarkMode;

  const _CustomSearchBar({required this.hint, required this.isDarkMode});

  @override
  State<_CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<_CustomSearchBar> {
  Timer? _searchDebounce;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final state = context.read<HomeBloc>().state;
    if (state is HomeLoaded && state.query.isNotEmpty) {
      _controller.text = state.query;
    }
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.searchBarHeight,
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? const Color(AppColors.surfaceDark)
            : const Color(AppColors.white),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: AppDimensions.shadowBlurRadius,
            offset: const Offset(0, AppDimensions.shadowOffsetY),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        onChanged: (query) {
          _searchDebounce?.cancel();
          _searchDebounce = Timer(const Duration(milliseconds: 350), () {
            context.read<HomeBloc>().add(SearchProductEvent(query));
          });
        },
        decoration: InputDecoration(
          hintText: widget.hint,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).iconTheme.color,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingMedium - 1,
          ),
        ),
      ),
    );
  }
}

class _SearchResultsList extends StatefulWidget {
  const _SearchResultsList();

  @override
  State<_SearchResultsList> createState() => _SearchResultsListState();
}

class _SearchResultsListState extends State<_SearchResultsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (!mounted) return;

    final position = _scrollController.position;

    if (position.extentAfter < 300) {
      final state = context.read<HomeBloc>().state;

      if (state is! HomeLoaded) return;
      if (!state.isSearchMode) return;
      if (state.isLoadingMoreSearchResults) return;
      if (!state.hasMoreSearchResults) return;

      context.read<HomeBloc>().add(const LoadMoreSearchResultsEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeError) {
          final l10n = AppLocalizations.of(context)!;
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.errorNetwork, textAlign: TextAlign.center),
                const SizedBox(height: AppDimensions.paddingMedium),
                ElevatedButton(
                  onPressed: () => context.read<HomeBloc>().add(
                    const LoadRecentScansEvent(),
                  ),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          );
        }

        final l10n = AppLocalizations.of(context)!;

        if (state is! HomeLoaded || !state.isSearchMode) {
          return Center(child: Text(l10n.searchTypePlaceholder));
        }

        if (state.recentScans.isEmpty) {
          if (state.isLoadingMoreSearchResults) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(child: Text(l10n.noProductsFound));
        }

        final showFooter = state.isLoadingMoreSearchResults;

        return ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          itemCount: state.recentScans.length + (showFooter ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= state.recentScans.length) {
              return const Padding(
                padding: EdgeInsets.all(AppDimensions.paddingMedium),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final ScanRecord scan = state.recentScans[index];

            return GestureDetector(
              onTap: () => context.pushNamed(
                'details',
                pathParameters: {'barcode': scan.barcode},
              ),
              child: RecentScanCard(
                key: ValueKey(scan.barcode),
                productName: scan.productName,
                barcode: scan.barcode,
                nutriScore: NutriScore.fromString(scan.nutritionGrade),
                imageUrl: scan.imageFrontUrl,
              ),
            );
          },
        );
      },
    );
  }
}
