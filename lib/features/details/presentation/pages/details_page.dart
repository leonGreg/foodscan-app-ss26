import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/features/details/presentation/bloc/details_bloc.dart';
import 'package:food_scan/features/details/presentation/widgets/product_header.dart';
import 'package:food_scan/features/details/presentation/widgets/nutrition_score_card.dart';
import 'package:food_scan/features/details/presentation/widgets/nutri_score_badge.dart';
import 'package:food_scan/features/details/presentation/widgets/eco_score_card.dart';
import 'package:food_scan/features/details/presentation/widgets/product_tabs.dart';

class DetailsPage extends StatefulWidget {
  final String barcode;

  const DetailsPage({super.key, required this.barcode});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<DetailsBloc>().add(LoadProductDetailsEvent(widget.barcode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoading) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          } else if (state is DetailsError) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
              ),
              body: Center(child: Text(state.message)),
            );
          } else if (state is DetailsLoaded) {
            final product = state.product;
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  color: Theme.of(context).iconTheme.color,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductHeader(product: product),
                    const SizedBox(height: AppDimensions.paddingLarge),
                    NutritionScoreCard(product: product),
                    const SizedBox(height: AppDimensions.paddingLarge),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingLarge,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: NutriScoreBadge(
                              nutritionGrade: product.nutritionGrade,
                            ),
                          ),
                          const SizedBox(width: AppDimensions.paddingMedium),
                          Expanded(
                            child: EcoScoreCard(ecoScore: product.ecoScore),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingLarge),
                    ProductTabs(product: product),
                    const SizedBox(height: AppDimensions.paddingLarge),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
