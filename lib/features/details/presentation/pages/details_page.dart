import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/nutrition.dart';
import 'package:food_scan/features/details/presentation/bloc/details_bloc.dart';
import 'package:food_scan/features/details/presentation/widgets/product_header.dart';
import 'package:food_scan/features/details/presentation/widgets/nutrition_score_card.dart';

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
    // Load product details when page is created
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
                title: Text(
                  product.productName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
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
                    NutritionScoreCard(nutritionGrade: product.nutritionGrade),
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
