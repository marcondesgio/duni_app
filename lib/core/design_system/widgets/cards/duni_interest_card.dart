import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';

/// Card de interesse usado principalmente no onboarding (seção 16 da
/// documentação): apresenta o interesse, permite seleção e reflete o estado
/// selecionado.
class DuniInterestCard extends StatelessWidget {
  const DuniInterestCard({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    this.onTap,
    this.enabled = true,
  });

  final String icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(DuniRadius.card),
        onTap: enabled ? onTap : null,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: DuniSpacing.md,
            horizontal: DuniSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: selected ? DuniColors.purple50 : DuniColors.white,
            borderRadius: BorderRadius.circular(DuniRadius.card),
            border: Border.all(
              color: selected ? DuniColors.purple200 : DuniColors.gray200,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: DuniSpacing.xs,
            children: [
              Text(icon, style: const TextStyle(fontSize: DuniSpacing.md)),
              Text(
                label,
                textAlign: TextAlign.center,
                style: DuniTypography.bodySmall.copyWith(
                  color: DuniColors.purple500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
