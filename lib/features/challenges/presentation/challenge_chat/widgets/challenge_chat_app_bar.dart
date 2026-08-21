import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/features/challenges/shared/shared.dart';
import 'package:flutter/material.dart';

/// Cabeçalho do chat do desafio: capa, nome, posição/check-ins do usuário e
/// um botão "+ Check-in" — tocar no restante do cabeçalho abre os
/// Detalhes/Ranking.
class ChallengeChatAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ChallengeChatAppBar({
    super.key,
    required this.challenge,
    required this.onTap,
    required this.onCheckin,
  });

  final ChallengeRef challenge;
  final VoidCallback onTap;
  final VoidCallback onCheckin;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 12);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: DuniGradients.navy),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DuniSpacing.xxs,
            vertical: DuniSpacing.xs,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: DuniSpacing.xs,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: DuniColors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Flexible(
                child: InkWell(
                  onTap: onTap,
                  child: Row(
                    spacing: DuniSpacing.sm,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(DuniRadius.small),
                        child: Image.network(
                          challenge.coverImageUrl,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 40,
                                height: 40,
                                color: DuniColors.white,
                              ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              challenge.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: DuniTypography.bodyLarge.copyWith(
                                color: DuniColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${challenge.myCheckins} check-ins',
                              style: DuniTypography.caption.copyWith(
                                color: DuniColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _CheckinButton(onTap: onCheckin),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckinButton extends StatelessWidget {
  const _CheckinButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(DuniRadius.pill),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: DuniSpacing.sm),
        padding: const EdgeInsets.symmetric(
          horizontal: DuniSpacing.sm,
          vertical: DuniSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: DuniColors.teal200,
          borderRadius: BorderRadius.circular(DuniRadius.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: DuniSpacing.xxs,
          children: [
            const Icon(Icons.add, size: 16, color: DuniColors.white),
            Text(
              'Check-in',
              style: DuniTypography.label.copyWith(
                color: DuniColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
