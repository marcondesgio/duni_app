import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';

/// Indicador de progresso do onboarding — "Etapa X de N" (seção 26 da
/// documentação).
class DuniOnboardingProgress extends StatelessWidget {
  const DuniOnboardingProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  }) : assert(currentStep >= 1 && currentStep <= totalSteps);

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: DuniSpacing.xs,
      children: [
        Row(
          children: [
            for (var step = 1; step <= totalSteps; step++) ...[
              if (step > 1) const SizedBox(width: DuniSpacing.xxs),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(DuniRadius.pill),
                  child: Container(
                    height: 4,
                    color: step <= currentStep
                        ? DuniColors.purple200
                        : DuniColors.gray200,
                  ),
                ),
              ),
            ],
          ],
        ),
        Text(
          'Etapa $currentStep de $totalSteps',
          style: DuniTypography.smallLabel.copyWith(
            color: DuniColors.gray300,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}
