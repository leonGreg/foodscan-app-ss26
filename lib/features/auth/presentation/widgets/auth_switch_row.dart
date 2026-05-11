import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';

class AuthSwitchRow extends StatelessWidget {
  final String question;
  final String actionLabel;
  final VoidCallback onTap;

  const AuthSwitchRow({
    super.key,
    required this.question,
    required this.actionLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(question, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(width: AppDimensions.paddingXSmall),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionLabel,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(AppColors.primaryGreen),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
