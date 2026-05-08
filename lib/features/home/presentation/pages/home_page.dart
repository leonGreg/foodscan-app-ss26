import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/config/theme/bloc/theme_bloc.dart';
import 'package:food_scan/l10n/app_localizations.dart';
import 'package:food_scan/features/home/presentation/bloc/home_bloc.dart';
import 'package:food_scan/features/home/presentation/widgets/no_scans_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: AppDimensions.appBarExpandedHeight,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(AppColors.primaryGreen),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
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
                          localizations.appTitle,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: BlocBuilder<ThemeBloc, ThemeState>(
                                builder: (context, state) {
                                  return Icon(
                                    state.themeMode == ThemeMode.dark
                                        ? Icons.light_mode
                                        : Icons.dark_mode,
                                    color: Colors.white,
                                  );
                                },
                              ),
                              onPressed: () {
                                context.read<ThemeBloc>().add(ToggleThemeEvent());
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              onPressed: () => {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.paddingXSmall),
                    Text(
                      localizations.homeSubtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.paddingXLarge + 8),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLarge,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.history,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          const SizedBox(width: AppDimensions.paddingSmall),
                          Text(
                            localizations.recentScans,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      // Recent Scans List
                      Expanded(
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is HomeLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              ); // TODO: Replace with Skeleton loader
                            } else if (state is HomeError) {
                              return Text(state.message);
                            }

                            // Check if there are scans, otherwise show NoScansWidget
                            return ListView(
                              padding: EdgeInsets.zero,
                              children: [

                                const NoScansWidget(),
                                // Placeholder for mockup TODO: Replace with actual data
                                // GestureDetector(
                                //   onTap: () {
                                //     // TODO Implement navigation to product details page
                                //   },
                                //   child: RecentScanCard(
                                //     productName: 'Nutella',
                                //     barcode: '3017620422003',
                                //     nutriScore: NutriScore.e,
                                //   ),
                                // ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Search bar and scan button
          Positioned(
            top: AppDimensions.searchBarTopOffset,
            left: AppDimensions.paddingLarge,
            right: AppDimensions.paddingLarge,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: AppDimensions.searchBarHeight,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(AppColors.surfaceDark)
                          : const Color(AppColors.white),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadiusMedium,
                      ),
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
                        hintText: localizations.searchHint,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.paddingMedium - 1, // 15
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingSmall),
                // Scan button
                GestureDetector(
                  onTap: () async {
                    final router = GoRouter.of(context);
                    final result = await router.push('/scanner');
                    if (result != null && result is String) {
                      // TODO: fetch product Details
                    }
                  },
                  child: Container(
                    width: AppDimensions.searchBarHeight,
                    height: AppDimensions.searchBarHeight,
                    decoration: BoxDecoration(
                      color: Color(AppColors.primaryGreen),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadiusMedium,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: AppDimensions.shadowBlurRadius,
                          offset: const Offset(0, AppDimensions.shadowOffsetY),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.qr_code_scanner,
                      color: Color(AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
