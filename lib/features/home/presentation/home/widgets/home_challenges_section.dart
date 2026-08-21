import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/features/challenges/shared/shared.dart';
import 'package:flutter/material.dart';

import '../home_state.dart';

class HomeChallengesSection extends StatelessWidget {
  const HomeChallengesSection({super.key, required this.challenges});

  final List<HomeChallengePreview> challenges;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (challenges.isEmpty)
          Center(
            child: Text(
              'Nenhum desafio em andamento ainda.',
              textAlign: TextAlign.center,
              style: DuniTypography.bodySmall.copyWith(
                color: DuniColors.purpleGray50,
              ),
            ),
          )
        else
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
      onTap: () => Navigator.of(context).pushNamed(
        ChallengesRouter.chatPage,
        arguments: ChallengeRef(
          id: challenge.id,
          name: challenge.name,
          interestEmoji: challenge.interestEmoji,
          interestLabel: challenge.interestLabel,
          coverImageUrl: challenge.imageUrl,
          currentDay: challenge.currentDay,
          totalDays: challenge.totalDays,
          myPosition: challenge.myPosition,
          myCheckins: challenge.myCheckins,
        ),
      ),
    );
  }
}
