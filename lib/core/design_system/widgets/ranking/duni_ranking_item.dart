import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';
import '../avatars/duni_avatar.dart';

/// Representa posições posteriores ao pódio no ranking (seção 24 da
/// documentação).
class DuniRankingItem extends StatelessWidget {
  const DuniRankingItem({
    super.key,
    required this.position,
    required this.name,
    required this.score,
    this.avatarUrl,
  });

  final int position;
  final String name;
  final int score;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DuniSpacing.xs),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '$position',
              style: DuniTypography.bodySmall.copyWith(
                color: DuniColors.textPrimary.withAlpha(160),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          DuniAvatar(imageUrl: avatarUrl, size: DuniAvatarSize.small),
          const SizedBox(width: DuniSpacing.sm),
          Expanded(
            child: Text(
              name,
              style: DuniTypography.body.copyWith(
                color: DuniColors.textPrimary,
              ),
            ),
          ),
          Text(
            '$score',
            style: DuniTypography.bodyLarge.copyWith(
              color: DuniColors.purple200,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
