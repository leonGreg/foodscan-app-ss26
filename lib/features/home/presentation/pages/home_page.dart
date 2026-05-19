import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/config/theme/bloc/theme_bloc.dart';
import 'package:food_scan/l10n/app_localizations.dart';
import 'package:food_scan/features/home/data/models/scan_record.dart';
import 'package:food_scan/features/home/presentation/bloc/home_bloc.dart';
import 'package:food_scan/features/home/presentation/widgets/no_scans_widget.dart';
import 'package:food_scan/features/home/presentation/widgets/recent_scan_card.dart';
import 'package:food_scan/config/constants/nutrition.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true, 
      body: _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _HomeHeader(),
        const SizedBox(height: AppDimensions.paddingMedium), 
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    final isSearch = state is HomeLoaded && state.isSearchMode;
                    final l10n = AppLocalizations.of(context)!;
                    
                    return _SectionHeader(
                      title: isSearch ? 'Search Results' : l10n.recentScans,
                      icon: isSearch ? Icons.search : Icons.history,
                    );
                  },
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                const Expanded(child: _RecentScansList()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(AppColors.primaryGreen),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppDimensions.borderRadiusXLarge),
          bottomRight: Radius.circular(AppDimensions.borderRadiusXLarge),
        ),
      ),
      padding: EdgeInsets.only(
        top: statusBarHeight + 12, 
        left: AppDimensions.paddingLarge,
        right: AppDimensions.paddingLarge,
        bottom: AppDimensions.paddingLarge, 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.appTitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const _HeaderActions(),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingXSmall),
          Text(
            l10n.homeSubtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          
          const SizedBox(height: AppDimensions.paddingMedium),
          
          _CustomSearchBar(hint: l10n.searchHint, isDarkMode: isDark),
        ],
      ),
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
      clipBehavior: Clip.antiAlias, 
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? const Color(AppColors.surfaceDark)
            : const Color(AppColors.white),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
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
          filled: false, 
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).iconTheme.color,
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    _controller.clear();
                    context.read<HomeBloc>().add(const SearchProductEvent(''));
                    setState(() {});
                  },
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingMedium - 1,
          ),
        ),
      ),
    );
  }
}

class _HeaderActions extends StatelessWidget {
  const _HeaderActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) => Icon(
              state.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: Colors.white,
            ),
          ),
          onPressed: () => context.read<ThemeBloc>().add(ToggleThemeEvent()),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).iconTheme.color),
        const SizedBox(width: AppDimensions.paddingSmall),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _RecentScansList extends StatefulWidget {
  const _RecentScansList();

  @override
  State<_RecentScansList> createState() => _RecentScansListState();
}

class _RecentScansListState extends State<_RecentScansList> {
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
      if (state.isLoadingMoreVisible) return;
      if (!state.hasMoreVisible) return;

      if (state.isSearchMode) {
        context.read<HomeBloc>().add(const LoadMoreSearchResultsEvent());
      } else {
        context.read<HomeBloc>().add(const LoadMoreRecentScansEvent());
      }
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
          return Center(child: Text(state.message));
        }

        if (state is HomeLoaded) {
          if (state.recentScans.isEmpty) {
            if (state.isLoadingMoreSearchResults) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isSearchMode) {
              return const Center(child: Text('No products found.'));
            }
            return const NoScansWidget();
          }

          final showFooter = state.isLoadingMoreVisible || state.isLoadingMoreSearchResults;

          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.only(bottom: 100, top: 0),
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
        }

        return const NoScansWidget();
      },
    );
  }
}