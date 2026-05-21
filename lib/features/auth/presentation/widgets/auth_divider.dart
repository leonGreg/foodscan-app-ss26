import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
          ),
          child: Text(
            AppLocalizations.of(context)!.or,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
