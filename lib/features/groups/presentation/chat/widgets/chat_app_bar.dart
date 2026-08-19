import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/features/groups/shared/shared.dart';
import 'package:flutter/material.dart';

/// Cabeçalho do chat: ícone do grupo, nome, participantes e um chevron —
/// tocar em qualquer ponto abre os Detalhes do Grupo.
class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key, required this.group, required this.onTap});

  final GroupRef group;
  final VoidCallback onTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 12);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: DuniGradients.purple),
      child: SafeArea(
        bottom: false,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DuniSpacing.xxs,
              vertical: DuniSpacing.xs,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: DuniColors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: DuniColors.white.withAlpha(40),
                    borderRadius: BorderRadius.circular(DuniRadius.medium),
                  ),
                  child: Text(group.icon, style: const TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: DuniSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        group.interestName,
                        style: DuniTypography.bodyLarge.copyWith(
                          color: DuniColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${group.participantCount} participantes',
                        style: DuniTypography.caption.copyWith(
                          color: DuniColors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: DuniColors.white.withAlpha(220),
                ),
                const SizedBox(width: DuniSpacing.xs),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
