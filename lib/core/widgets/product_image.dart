import 'package:cached_network_image/cached_network_image.dart';
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
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _Placeholder(
        width: width,
        height: height,
        borderRadius: borderRadius,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => _LoadingPlaceholder(
          width: width,
          height: height,
          borderRadius: borderRadius,
        ),
        errorWidget: (context, url, error) => _Placeholder(
          width: width,
          height: height,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

class _LoadingPlaceholder extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const _LoadingPlaceholder({
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(AppColors.lightGray),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const _Placeholder({
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(AppColors.lightGray),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          AppStrings.noImagePlaceholder,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
