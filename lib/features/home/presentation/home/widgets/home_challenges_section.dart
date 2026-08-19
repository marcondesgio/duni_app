import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../home_state.dart';

class HomeChallengesSection extends StatelessWidget {
  const HomeChallengesSection({super.key, required this.challenges});

  final List<HomeChallengePreview> challenges;

  @override
  Widget build(BuildContext context) {
    if (challenges.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Desafios em andamento',
          style: DuniTypography.heading3.copyWith(color: DuniColors.purple500),
        ),
        const SizedBox(height: DuniSpacing.sm),
        for (var i = 0; i < challenges.length; i++) ...[
          if (i > 0) const SizedBox(height: DuniSpacing.sm),
          _ChallengeCard(challenge: challenges[i]),
        ],
      ],
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({required this.challenge});

  final HomeChallengePreview challenge;

  @override
  Widget build(BuildContext context) {
    return DuniChallengeCard(
      imageUrl: challenge.imageUrl,
      name: challenge.name,
      interestEmoji: challenge.interestEmoji,
      interestLabel: challenge.interestLabel,
      periodLabel: challenge.periodLabel,
      status: challenge.status,
      participantAvatarUrls: challenge.participantAvatarUrls,
      participantCount: challenge.participantCount,
      checkinInfo: challenge.checkinInfo,
      daysUntilStart: challenge.daysUntilStart,
    );
  }
}
