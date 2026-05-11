import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class NovaBadge extends StatelessWidget {
  final int? novaGroup;

  const NovaBadge({super.key, required this.novaGroup});

  @override
  Widget build(BuildContext context) {
    if (novaGroup == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingSmall,
            vertical: AppDimensions.paddingXSmall / 2,
          ),
          decoration: BoxDecoration(
            color: _getNovaColor(novaGroup!),
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusSmall,
            ),
          ),
          child: Text(
            'NOVA $novaGroup',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        Expanded(
          child: Text(
            _getNovaText(novaGroup!, l10n),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(AppColors.mediumGray),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Color _getNovaColor(int group) {
    switch (group) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow[800]!;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getNovaText(int group, AppLocalizations l10n) {
    switch (group) {
      case 1:
        return l10n.nova1;
      case 2:
        return l10n.nova2;
      case 3:
        return l10n.nova3;
      case 4:
        return l10n.nova4;
      default:
        return l10n.unknown;
    }
  }
}
