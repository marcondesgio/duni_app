import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../onboarding_state.dart';
import '../onboarding_viewmodal.dart';

/// Etapa 1 de 2 do onboarding propriamente dito (seções 16 e 27 da
/// documentação): seleção de interesses, mínimo de 3 para continuar.
class OnboardingInterestsStep extends StatelessWidget {
  const OnboardingInterestsStep({super.key, required this.viewModel});

  final OnboardingViewmodal viewModel;

  @override
  Widget build(BuildContext context) {
    final state = viewModel.state;
    final selectedCount = state.selectedInterestIds.length;
    final canContinue = state.canContinueInterests;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DuniSpacing.xs,
      children: [
        const DuniOnboardingProgress(currentStep: 2, totalSteps: 3),
        const SizedBox(height: DuniSpacing.md),
        Text(
          'O que te move?',
          style: DuniTypography.heading2.copyWith(color: DuniColors.purple500),
        ),
        Text(
          'Escolha pelo menos 3 interesses.',
          style: DuniTypography.bodySmall.copyWith(
            color: DuniColors.purpleGray100,
          ),
        ),
        const SizedBox(height: DuniSpacing.sm),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: DuniSpacing.xs,
              mainAxisSpacing: DuniSpacing.xs,
              childAspectRatio: 2,
            ),
            itemCount: viewModel.interests.length,
            itemBuilder: (context, index) {
              final interest = viewModel.interests[index];
              return DuniInterestCard(
                icon: interest.emoji,
                label: interest.label,
                selected: state.selectedInterestIds.contains(interest.id),
                onTap: () => viewModel.toggleInterest(interest.id),
              );
            },
          ),
        ),
        const SizedBox(height: DuniSpacing.sm),
        DuniButton(
          label:
              'Continuar ($selectedCount/${OnboardingState.minSelectedInterests})',
          state: canContinue
              ? DuniButtonState.enabled
              : DuniButtonState.disabled,
          onPressed: canContinue ? viewModel.continueFromInterests : null,
        ),
      ],
    );
  }
}
