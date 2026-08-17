import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';
import '../avatars/duni_avatar.dart';

class DuniPodiumEntry {
  const DuniPodiumEntry({
    required this.name,
    required this.score,
    this.avatarUrl,
  });

  final String name;
  final int score;
  final String? avatarUrl;
}

/// Pódio do top 3 do ranking, com destaque visual maior para o 1º lugar
/// (seção 23 da documentação).
class DuniRankingPodium extends StatelessWidget {
  const DuniRankingPodium({
    super.key,
    required this.first,
    this.second,
    this.third,
  });

  final DuniPodiumEntry first;
  final DuniPodiumEntry? second;
  final DuniPodiumEntry? third;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (second != null)
          Expanded(
            child: _PodiumSlot(
              medal: '🥈',
              entry: second!,
              avatarSize: DuniAvatarSize.small,
            ),
          ),
        Expanded(
          flex: 2,
          child: _PodiumSlot(
            medal: '🥇',
            entry: first,
            avatarSize: DuniAvatarSize.large,
            isFirst: true,
          ),
        ),
        if (third != null)
          Expanded(
            child: _PodiumSlot(
              medal: '🥉',
              entry: third!,
              avatarSize: DuniAvatarSize.small,
            ),
          ),
      ],
    );
  }
}

class _PodiumSlot extends StatelessWidget {
  const _PodiumSlot({
    required this.medal,
    required this.entry,
    required this.avatarSize,
    this.isFirst = false,
  });

  final String medal;
  final DuniPodiumEntry entry;
  final DuniAvatarSize avatarSize;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(medal, style: TextStyle(fontSize: isFirst ? 32 : 24)),
        const SizedBox(height: DuniSpacing.xxs),
        DuniAvatar(imageUrl: entry.avatarUrl, size: avatarSize),
        const SizedBox(height: DuniSpacing.xxs),
        Text(
          entry.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: DuniTypography.bodySmall.copyWith(
            color: DuniColors.purple500,
            fontWeight: isFirst ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        Text(
          '${entry.score}',
          style: DuniTypography.caption.copyWith(
            color: DuniColors.purple500.withAlpha(160),
          ),
        ),
      ],
    );
  }
}
