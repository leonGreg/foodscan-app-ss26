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
    return const Scaffold(body: _HomeContent());
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _HomeHeader(),
        const SizedBox(height: AppDimensions.paddingXLarge + 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionHeader(
                  title: AppLocalizations.of(context)!.recentScans,
                  icon: Icons.history,
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
        ],
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
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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

          final showFooter = state.isLoadingMoreVisible;

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
        }

        return const NoScansWidget();
      },
    );
  }
}
