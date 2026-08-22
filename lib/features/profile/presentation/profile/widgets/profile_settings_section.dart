import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Placeholder: "Notificações" e "Excluir minha conta" não têm telas de
/// destino especificadas ainda — os callbacks só sinalizam a ação
/// (ver `ProfileView`).
class ProfileSettingsSection extends StatelessWidget {
  const ProfileSettingsSection({
    super.key,
    required this.onNotifications,
    required this.onDeleteAccount,
  });

  final VoidCallback onNotifications;
  final VoidCallback onDeleteAccount;

  @override
  Widget build(BuildContext context) {
    return DuniCard(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _DarkModeRow(),
          const DuniDivider(),
          _SettingsRow(label: 'Notificações', onTap: onNotifications),
          const DuniDivider(),
          _SettingsRow(label: 'Editar interesses', onTap: onNotifications),
          const DuniDivider(),
          _SettingsRow(
            label: 'Excluir minha conta',
            color: DuniColors.pink,
            onTap: onDeleteAccount,
          ),
        ],
      ),
    );
  }
}

/// Alterna `DuniThemeController.instance` diretamente — modo claro/escuro é
/// estado do app inteiro, não desta tela, por isso não passa pelo
/// `ProfileViewmodal` como o resto do estado desta tela.
class _DarkModeRow extends StatelessWidget {
  const _DarkModeRow();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: DuniThemeController.instance,
      builder: (context, _) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DuniSpacing.md,
          vertical: DuniSpacing.sm,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Modo escuro',
                style: DuniTypography.body.copyWith(
                  color: DuniColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DuniSwitch(
              value: DuniThemeController.instance.isDark,
              onChanged: DuniThemeController.instance.setDark,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.label, required this.onTap, this.color});

  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final resolvedColor = color ?? DuniColors.textPrimary;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DuniSpacing.md,
          vertical: DuniSpacing.sm,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: DuniTypography.body.copyWith(
                  color: resolvedColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: resolvedColor),
          ],
        ),
      ),
    );
  }
}
