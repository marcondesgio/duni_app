import 'package:flutter/material.dart';
import 'package:duni_app/core/design_system/design_system.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(icon, style: const TextStyle(fontSize: DuniSpacing.lg)),
              const SizedBox(width: DuniSpacing.sm),
              if (unreadCount > 0) ...[
                const SizedBox(width: DuniSpacing.sm),
                DuniBadge(count: unreadCount),
              ],
            ],
          ),
          SizedBox(height: DuniSpacing.sm),
          Text(
            interestName,
            style: DuniTypography.body.copyWith(
              color: DuniColors.purple500,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: DuniSpacing.xxs),
          Text(
            '$participantCount participantes',
            style: DuniTypography.bodySmall.copyWith(
              color: DuniColors.purpleGray100,
            ),
          ),
        ],
      ),
    );
  }
}
