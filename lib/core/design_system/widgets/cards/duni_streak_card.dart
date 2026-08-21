import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';
import 'duni_card.dart';

/// Representa a sequência de participação do usuário (ex.: "🔥 3 dias
/// seguidos"), sempre na cor amarela/amber do Design System (seção 25).
class DuniStreakCard extends StatelessWidget {
  const DuniStreakCard({super.key, required this.days, this.subtitle});

  final int days;

  /// Texto secundário opcional (ex.: "Não perca hoje").
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return DuniCard(
      backgroundColor: DuniColors.yellow300.withAlpha(35),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 24)),
          const SizedBox(width: DuniSpacing.xs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$days ${days == 1 ? 'dia seguido' : 'dias seguidos'}',
                style: DuniTypography.bodyLarge.copyWith(
                  color: DuniColors.purple500,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: DuniTypography.bodySmall.copyWith(
                    color: DuniColors.purpleGray100,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
