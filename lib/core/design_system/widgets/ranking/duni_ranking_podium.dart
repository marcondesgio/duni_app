import 'package:duni_app/core/design_system/gradients/duni_gradients.dart';
import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../shadows/duni_shadows.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';
import '../avatars/duni_avatar.dart';

class DuniPodiumEntry {
  const DuniPodiumEntry({
    required this.name,
    required this.score,
    this.avatarUrl,
    this.isYourUser = false,
  });

  final String name;
  final int score;
  final String? avatarUrl;

  /// Aplica o anel em gradiente do [DuniAvatar] para destacar o usuário
  /// atual no pódio (ex.: "Gabi · você"). Independente do anel dourado do
  /// 1º lugar — os dois podem coexistir.
  final bool isYourUser;
}

/// Pódio do top 3 do ranking, com destaque visual maior para o 1º lugar
/// (👑 + anel dourado, pedestal mais alto) e um card de posição colorido
/// por lugar (seção 23 da documentação).
class DuniRankingPodium extends StatelessWidget {
  const DuniRankingPodium({
    super.key,
    required this.first,
    this.second,
    this.third,
    this.scoreLabel = 'pontos',
  });

  final DuniPodiumEntry first;
  final DuniPodiumEntry? second;
  final DuniPodiumEntry? third;

  /// Unidade exibida sob a posição (ex.: "check-ins"). Placeholder: a
  /// documentação não define uma unidade padrão.
  final String scoreLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (second != null)
          Expanded(
            child: _PodiumSlot(
              position: 2,
              entry: second!,
              avatarSize: DuniAvatarSize.small,
              scoreLabel: scoreLabel,
            ),
          ),
        Expanded(
          child: _PodiumSlot(
            position: 1,
            entry: first,
            avatarSize: DuniAvatarSize.large,
            scoreLabel: scoreLabel,
            isFirst: true,
          ),
        ),
        if (third != null)
          Expanded(
            child: _PodiumSlot(
              position: 3,
              entry: third!,
              avatarSize: DuniAvatarSize.small,
              scoreLabel: scoreLabel,
            ),
          ),
      ],
    );
  }
}

class _PodiumSlot extends StatelessWidget {
  const _PodiumSlot({
    required this.position,
    required this.entry,
    required this.avatarSize,
    required this.scoreLabel,
    this.isFirst = false,
  });

  final int position;
  final DuniPodiumEntry entry;
  final DuniAvatarSize avatarSize;
  final String scoreLabel;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final avatar = DuniAvatar(
      imageUrl: entry.avatarUrl,
      size: avatarSize,
      isYourUser: entry.isYourUser,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DuniSpacing.xxs),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isFirst) ...[
            const Text('👑', style: TextStyle(fontSize: 26)),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.all(DuniSpacing.xxs),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: DuniColors.yellow200,
              ),
              child: avatar,
            ),
          ] else
            avatar,
          const SizedBox(height: DuniSpacing.xxs),
          Text(
            entry.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: DuniTypography.bodySmall.copyWith(
              color: DuniColors.purple500,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: DuniSpacing.xs),
          _PositionCard(
            position: position,
            score: entry.score,
            scoreLabel: scoreLabel,
            isFirst: isFirst,
          ),
        ],
      ),
    );
  }
}

class _PositionCard extends StatelessWidget {
  const _PositionCard({
    required this.position,
    required this.score,
    required this.scoreLabel,
    required this.isFirst,
  });

  final int position;
  final int score;
  final String scoreLabel;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isFirst ? DuniSpacing.md : DuniSpacing.sm,
      ),
      decoration: BoxDecoration(
        gradient: isFirst ? DuniGradients.ranking : null,
        color: _backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DuniRadius.large),
          topRight: Radius.circular(DuniRadius.large),
        ),
        boxShadow: isFirst ? null : DuniShadows.card,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$positionº',
            style: (isFirst ? DuniTypography.heading2 : DuniTypography.heading3)
                .copyWith(color: _numberColor, fontWeight: FontWeight.w700),
          ),
          Text(
            '$score $scoreLabel',
            style: DuniTypography.bodySmall.copyWith(color: _captionColor),
          ),
        ],
      ),
    );
  }

  Color get _backgroundColor {
    switch (position) {
      case 1:
        return DuniColors.yellow300;
      default:
        return DuniColors.white;
    }
  }

  Color get _numberColor {
    switch (position) {
      case 1:
        return DuniColors.white;
      case 2:
        return DuniColors.purpleGray100;
      default:
        return DuniColors.warning;
    }
  }

  Color get _captionColor {
    switch (position) {
      case 1:
        return DuniColors.white.withAlpha(220);
      case 2:
        return DuniColors.purpleGray100;
      default:
        return DuniColors.warning.withAlpha(200);
    }
  }
}
