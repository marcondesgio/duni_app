import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../onboarding_viewmodal.dart';

/// Etapa 2 de 2 do onboarding (seção 28 da documentação): foto opcional, com
/// opção explícita e visível de continuar sem adicionar uma imagem.
class OnboardingPhotoStep extends StatelessWidget {
  const OnboardingPhotoStep({super.key, required this.viewModel});

  final OnboardingViewmodal viewModel;

  /// Placeholder: sem plugin de câmera/galeria integrado ainda (o Design
  /// System não deve depender de um picker específico — ver
  /// `DuniMediaPicker`). Usamos uma URL de exemplo só para exercitar o fluxo.
  static const _samplePhotoUrl =
      'https://picsum.photos/seed/duni-onboarding-photo/400';

  @override
  Widget build(BuildContext context) {
    final state = viewModel.state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: DuniSpacing.xs,
      children: [
        const DuniOnboardingProgress(currentStep: 3, totalSteps: 3),
        const SizedBox(height: DuniSpacing.md),
        Text(
          'Adicione uma foto',
          textAlign: TextAlign.center,
          style: DuniTypography.heading2.copyWith(
            color: DuniColors.textPrimary,
          ),
        ),
        Text(
          'Ajude os colegas a te reconhecerem. Ou se preferir você pode continuar sem foto.',
          textAlign: TextAlign.center,
          style: DuniTypography.bodySmall.copyWith(
            color: DuniColors.textSecondary,
          ),
        ),
        const SizedBox(height: DuniSpacing.lg),
        DuniAvatarPicker(
          imageUrl: state.photoUrl,
          initials: state.name.isNotEmpty ? state.name[0].toUpperCase() : null,
          onTap: () => viewModel.setPhoto(_samplePhotoUrl),
        ),
        const Spacer(),
        DuniButton(
          label: 'Concluir cadastro',
          onPressed: viewModel.completeOnboarding,
        ),
        DuniButton(
          label: 'Deixar para depois',
          variant: DuniButtonVariant.text,
          onPressed: viewModel.completeOnboarding,
        ),
      ],
    );
  }
}
