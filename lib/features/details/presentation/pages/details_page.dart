import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/features/details/presentation/bloc/details_bloc.dart';
import 'package:food_scan/features/home/presentation/bloc/home_bloc.dart';
import 'package:food_scan/features/details/presentation/widgets/product_header.dart';
import 'package:food_scan/features/details/presentation/widgets/nutrition_score_card.dart';
import 'package:food_scan/features/details/presentation/widgets/nutri_score_badge.dart';
import 'package:food_scan/features/details/presentation/widgets/eco_score_card.dart';
import 'package:food_scan/features/details/presentation/widgets/additive_summary_card.dart';
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Theme.of(context).iconTheme.color,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocListener<DetailsBloc, DetailsState>(
        listener: (context, state) {
          if (state is DetailsLoaded) {
            context.read<HomeBloc>().add(AddProductToHistoryEvent(state.product));
          }
        },
        child: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            if (state is DetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetailsError) {
              return Center(child: Text(state.message));
            } else if (state is DetailsLoaded) {
              return _ProductDetails(product: state.product);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;

  const _ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductHeader(product: product),
          const SizedBox(height: AppDimensions.paddingLarge),
          NutritionScoreCard(product: product),
          const SizedBox(height: AppDimensions.paddingLarge),
          _ScoreBadges(product: product),
          const SizedBox(height: AppDimensions.paddingLarge),
          AdditiveSummaryCard(additives: product.additivesTags),
          const SizedBox(height: AppDimensions.paddingLarge),
          ProductTabs(product: product),
          const SizedBox(height: AppDimensions.paddingLarge),
        ],
      ),
    );
  }
}

class _ScoreBadges extends StatelessWidget {
  final Product product;

  const _ScoreBadges({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: NutriScoreBadge(nutritionGrade: product.nutritionGrade)),
          const SizedBox(width: AppDimensions.paddingMedium),
          Expanded(child: EcoScoreCard(ecoScore: product.ecoScore)),
        ],
      ),
    );
  }
}
