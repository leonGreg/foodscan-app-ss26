import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/config/constants/strings.dart';

class ProductImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final double borderRadius;

  const ProductImage({
    super.key,
    required this.imageUrl,
    this.width = 100,
    this.height = 100,
    this.borderRadius = AppDimensions.borderRadiusMedium,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(AppColors.lightGray),
        borderRadius: BorderRadius.circular(borderRadius),
        image: imageUrl != null && imageUrl!.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              )
            : const DecorationImage(
                image: AssetImage(AppStrings.noImagePlaceholder),
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
