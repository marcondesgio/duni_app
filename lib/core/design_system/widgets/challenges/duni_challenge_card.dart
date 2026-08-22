import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

enum DuniChallengeStatus {
  ongoing,
  upcoming,
  ended;

  String label({int? daysUntilStart}) {
    switch (this) {
      case DuniChallengeStatus.ongoing:
        return 'Em andamento';
      case DuniChallengeStatus.upcoming:
        return 'Começa em ${daysUntilStart ?? 0} dias';
      case DuniChallengeStatus.ended:
        return 'Encerrado';
    }
  }

  Color get colorBackground {
    switch (this) {
      case DuniChallengeStatus.ongoing:
        return DuniColors.teal50;
      case DuniChallengeStatus.upcoming:
        return DuniColors.yellow50;
      case DuniChallengeStatus.ended:
        return DuniColors.gray100;
    }
  }

  Color get colorLabel {
    switch (this) {
      case DuniChallengeStatus.ongoing:
        return DuniColors.teal200;
      case DuniChallengeStatus.upcoming:
        return DuniColors.warning;
      case DuniChallengeStatus.ended:
        return DuniColors.gray300;
    }
  }
}

/// Representa um desafio: imagem, nome, interesse, período, status,
/// participantes/avatares e informações de check-in (seção 19).
class DuniChallengeCard extends StatelessWidget {
  const DuniChallengeCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.interestEmoji,
    required this.interestLabel,
    required this.periodLabel,
    required this.status,
    required this.participantAvatarUrls,
    required this.participantCount,
    this.checkinInfo,
    this.daysUntilStart,
    this.onTap,
  });

  final String imageUrl;
  final String name;
  final String interestEmoji;
  final String interestLabel;
  final String periodLabel;
  final DuniChallengeStatus status;
  final List<String> participantAvatarUrls;
  final int participantCount;
  final String? checkinInfo;
  final int? daysUntilStart;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DuniCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(DuniRadius.card),
            ),
            child: AspectRatio(
              aspectRatio: 21 / 9,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: DuniColors.gray200),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(DuniSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: DuniSpacing.xs,
              children: [
                Row(
                  spacing: DuniSpacing.xs,
                  children: [
                    DuniInterestChip(
                      emoji: interestEmoji,
                      label: interestLabel,
                    ),
                    _StatusPill(status: status, daysUntilStart: daysUntilStart),
                  ],
                ),
                Flexible(
                  child: Text(
                    name,
                    style: DuniTypography.bodyLarge.copyWith(
                      color: DuniColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  spacing: DuniSpacing.xs,
                  children: [
                    Text(
                      periodLabel,
                      style: DuniTypography.bodySmall.copyWith(
                        color: DuniColors.textPrimary.withAlpha(160),
                      ),
                    ),
                    if (checkinInfo != null) ...[
                      Text(
                        checkinInfo!,
                        style: DuniTypography.caption.copyWith(
                          color: DuniColors.teal200,
                        ),
                      ),
                    ],
                  ],
                ),
                Row(
                  spacing: DuniSpacing.xs,
                  children: [
                    _AvatarStack(urls: participantAvatarUrls),
                    Text(
                      '$participantCount participantes',
                      style: DuniTypography.caption.copyWith(
                        color: DuniColors.textPrimary.withAlpha(160),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status, required this.daysUntilStart});

  final DuniChallengeStatus status;
  final int? daysUntilStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DuniSpacing.sm,
        vertical: DuniSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: status.colorBackground,
        borderRadius: BorderRadius.circular(DuniRadius.pill),
      ),
      child: Text(
        status.label(daysUntilStart: daysUntilStart),
        style: DuniTypography.caption.copyWith(
          color: status.colorLabel,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack({required this.urls});

  final List<String> urls;

  @override
  Widget build(BuildContext context) {
    const overlap = 12.0;
    final shown = urls.take(3).toList();
    return SizedBox(
      width: shown.isEmpty
          ? 0
          : (shown.length - 1) * overlap + DuniAvatarSize.xs.diameter,
      height: DuniAvatarSize.xs.diameter,
      child: Stack(
        children: [
          for (var i = 0; i < shown.length; i++) ...[
            Positioned(
              left: i * overlap,
              child: DuniAvatar(imageUrl: shown[i], size: DuniAvatarSize.xs),
            ),
          ],
        ],
      ),
    );
  }
}
