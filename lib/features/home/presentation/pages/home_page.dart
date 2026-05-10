import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/config/theme/bloc/theme_bloc.dart';
import 'package:food_scan/l10n/app_localizations.dart';
import 'package:food_scan/features/home/presentation/bloc/home_bloc.dart';
import 'package:food_scan/features/home/presentation/widgets/no_scans_widget.dart';
import 'package:food_scan/features/home/presentation/widgets/recent_scan_card.dart';
import 'package:food_scan/features/scanner/presentation/bloc/scanner_bloc.dart';
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
      body: Stack(
        children: [
          _HomeContent(),
          _SearchBarOverlay(),
        ],
      ),
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
        const SizedBox(height: AppDimensions.paddingXLarge + 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge),
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
              state.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
          ),
          onPressed: () => context.read<ThemeBloc>().add(ToggleThemeEvent()),
        ),
        IconButton(
          icon: const Icon(Icons.info_outline, color: Colors.white),
          onPressed: () => {},
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

class _RecentScansList extends StatelessWidget {
  const _RecentScansList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) return const Center(child: CircularProgressIndicator());
        if (state is HomeError) return Text(state.message);
        if (state is HomeLoaded) {
          if (state.recentScans.isEmpty) return const NoScansWidget();
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: state.recentScans.length,
            itemBuilder: (context, index) {
              final product = state.recentScans[index];
              return GestureDetector(
                onTap: () => context.pushNamed('details', pathParameters: {'barcode': product.code}),
                child: RecentScanCard(
                  productName: product.productName,
                  barcode: product.code,
                  nutriScore: NutriScore.fromString(product.nutritionGrade) ?? NutriScore.c,
                  imageUrl: product.imageFrontUrl,
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
      child: Row(
        children: [
          Expanded(
            child: _CustomSearchBar(hint: l10n.searchHint, isDarkMode: isDarkMode),
          ),
          const SizedBox(width: AppDimensions.paddingSmall),
          const _ScanButton(),
        ],
      ),
    );
  }
}

class _CustomSearchBar extends StatelessWidget {
  final String hint;
  final bool isDarkMode;

  const _CustomSearchBar({required this.hint, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.searchBarHeight,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(AppColors.surfaceDark) : const Color(AppColors.white),
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
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
          contentPadding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingMedium - 1),
        ),
      ),
    );
  }
}

class _ScanButton extends StatelessWidget {
  const _ScanButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final scannerBloc = context.read<ScannerBloc>();
        final router = GoRouter.of(context);
        final result = await router.push('/scanner');

        if (result != null && result is String) {
          await router.pushNamed('details', pathParameters: {'barcode': result});
          scannerBloc.add(const ScannerResetEvent());
        }
      },
      child: Container(
        width: AppDimensions.searchBarHeight,
        height: AppDimensions.searchBarHeight,
        decoration: BoxDecoration(
          color: const Color(AppColors.primaryGreen),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: AppDimensions.shadowBlurRadius,
              offset: const Offset(0, AppDimensions.shadowOffsetY),
            ),
          ],
        ),
        child: const Icon(Icons.qr_code_scanner, color: Color(AppColors.white)),
      ),
    );
  }
}
