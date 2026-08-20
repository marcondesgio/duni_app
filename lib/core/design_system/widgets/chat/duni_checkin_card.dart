import 'package:flutter/material.dart';
import 'package:duni_app/core/design_system/design_system.dart';

/// Card de check-in — visualmente distinto de uma mensagem comum de chat,
/// entrando na conversa como um card próprio (seção 22 da documentação).
class DuniCheckinCard extends StatelessWidget {
  const DuniCheckinCard({
    super.key,
    required this.userName,
    required this.photoUrl,
    required this.description,
    required this.dateTimeLabel,
    this.avatarUrl,
    this.onTap,
  });

  final String userName;
  final String photoUrl;
  final String description;
  final String dateTimeLabel;
  final String? avatarUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DuniCard(
      onTap: onTap,
      backgroundColor: DuniColors.teal200.withAlpha(20),
      padding: const EdgeInsets.all(DuniSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              DuniAvatar(imageUrl: avatarUrl, size: DuniAvatarSize.xs),
              const SizedBox(width: DuniSpacing.xs),
              Expanded(
                child: Text(
                  userName,
                  style: DuniTypography.label.copyWith(
                    color: DuniColors.purple500,
                  ),
                ),
              ),
              Icon(Icons.check_circle, size: 16, color: DuniColors.teal200),
              const SizedBox(width: DuniSpacing.xxs),
              Text(
                'Check-in',
                style: DuniTypography.caption.copyWith(
                  color: DuniColors.teal200,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: DuniSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(DuniRadius.small),
            child: Image.network(
              photoUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(height: 160, color: DuniColors.gray200),
            ),
          ),
          const SizedBox(height: DuniSpacing.xs),
          Text(
            description,
            style: DuniTypography.body.copyWith(color: DuniColors.purple500),
          ),
          const SizedBox(height: DuniSpacing.xxs),
          Text(
            dateTimeLabel,
            style: DuniTypography.caption.copyWith(
              color: DuniColors.purple500.withAlpha(140),
            ),
          ),
        ],
      ),
    );
  }
}
