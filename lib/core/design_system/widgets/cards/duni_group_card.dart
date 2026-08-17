import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';
import '../badges/duni_badge.dart';
import 'duni_card.dart';

/// Representa um grupo baseado em interesse: ícone, nome, número de
/// participantes e mensagens não lidas quando aplicável (seção 18).
class DuniGroupCard extends StatelessWidget {
  const DuniGroupCard({
    super.key,
    required this.icon,
    required this.interestName,
    required this.participantCount,
    this.unreadCount = 0,
    this.onTap,
  });

  final String icon;
  final String interestName;
  final int participantCount;
  final int unreadCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DuniCard(
      onTap: onTap,
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: DuniSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  interestName,
                  style: DuniTypography.bodyLarge.copyWith(
                    color: DuniColors.purple500,
                  ),
                ),
                const SizedBox(height: DuniSpacing.xxs),
                Text(
                  '$participantCount participantes',
                  style: DuniTypography.bodySmall.copyWith(
                    color: DuniColors.purple500.withAlpha(160),
                  ),
                ),
              ],
            ),
          ),
          if (unreadCount > 0) ...[
            const SizedBox(width: DuniSpacing.sm),
            DuniBadge(count: unreadCount),
          ],
        ],
      ),
    );
  }
}
