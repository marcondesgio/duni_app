import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/features/groups/shared/shared.dart';
import 'package:flutter/material.dart';

/// Cabeçalho grande dos Detalhes do Grupo: voltar, "Desvincular" (placeholder
/// inerte — não há lógica real de associação a grupo ainda), ícone, nome e
/// subtítulo.
class GroupDetailsHeader extends StatelessWidget {
  const GroupDetailsHeader({super.key, required this.group});

  final GroupRef group;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: DuniGradients.purple),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            DuniSpacing.xs,
            DuniSpacing.xs,
            DuniSpacing.md,
            DuniSpacing.lg,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: DuniColors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  _UnlinkButton(onTap: () {}),
                ],
              ),
              const SizedBox(height: DuniSpacing.xs),
              Container(
                width: 72,
                height: 72,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: DuniColors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(DuniRadius.large),
                ),
                child: Text(group.icon, style: const TextStyle(fontSize: 36)),
              ),
              const SizedBox(height: DuniSpacing.sm),
              Text(
                group.interestName,
                style: DuniTypography.heading2.copyWith(
                  color: DuniColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: DuniSpacing.xxs),
              Text(
                'Grupo da Nexora · ${group.participantCount} participantes',
                style: DuniTypography.bodySmall.copyWith(
                  color: DuniColors.white.withAlpha(200),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnlinkButton extends StatelessWidget {
  const _UnlinkButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(DuniRadius.pill),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DuniSpacing.sm,
          vertical: DuniSpacing.xxs,
        ),
        decoration: BoxDecoration(
          color: DuniColors.white.withAlpha(40),
          borderRadius: BorderRadius.circular(DuniRadius.pill),
          border: Border.all(color: DuniColors.white.withAlpha(90)),
        ),
        child: Text(
          'Desvincular',
          style: DuniTypography.label.copyWith(color: DuniColors.white),
        ),
      ),
    );
  }
}
