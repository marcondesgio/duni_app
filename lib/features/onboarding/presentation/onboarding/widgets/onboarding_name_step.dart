import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../onboarding_viewmodal.dart';

class OnboardingNameStep extends StatefulWidget {
  const OnboardingNameStep({super.key, required this.viewModel});

  final OnboardingViewmodal viewModel;

  @override
  State<OnboardingNameStep> createState() => _OnboardingNameStepState();
}

class _OnboardingNameStepState extends State<OnboardingNameStep> {
  late final _controller = TextEditingController(
    text: widget.viewModel.state.name,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit = widget.viewModel.state.canSubmitName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DuniSpacing.xs,
      children: [
        const DuniOnboardingProgress(currentStep: 1, totalSteps: 3),
        const SizedBox(height: DuniSpacing.md),
        // Expanded + SingleChildScrollView (em vez de Spacer direto no
        // Column): quando o teclado abre e some espaço disponível, o
        // conteúdo aqui dentro rola em vez de causar overflow — só o banner
        // e o botão abaixo ficam realmente fixos.
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: DuniSpacing.xs,
              children: [
                Text(
                  'Como você quer ser chamado?',
                  style: DuniTypography.heading2.copyWith(
                    color: DuniColors.purple500,
                  ),
                ),
                Text(
                  'É esse nome que os colegas vão ver nos grupos.',
                  style: DuniTypography.bodySmall.copyWith(
                    color: DuniColors.purpleGray100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: DuniSpacing.sm),
                  child: DuniTextField(
                    label: '',
                    hintText: 'Digite seu nome ou apelido',
                    controller: _controller,
                    onChanged: widget.viewModel.updateName,
                  ),
                ),
              ],
            ),
          ),
        ),
        DuniBanner(
          icon: "💡",
          text: 'Apelidos funcionam melhor. No duni ninguém entra pelo cargo.',
          type: BannerType.success,
        ),
        DuniButton(
          label: 'Continuar',
          state: canSubmit ? DuniButtonState.enabled : DuniButtonState.disabled,
          onPressed: canSubmit ? widget.viewModel.submitName : null,
        ),
      ],
    );
  }
}
