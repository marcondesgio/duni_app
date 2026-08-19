import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../onboarding_viewmodal.dart';

class OnboardingLoginStep extends StatefulWidget {
  const OnboardingLoginStep({super.key, required this.viewModel});

  final OnboardingViewmodal viewModel;

  @override
  State<OnboardingLoginStep> createState() => _OnboardingLoginStepState();
}

class _OnboardingLoginStepState extends State<OnboardingLoginStep> {
  late final _controller = TextEditingController(
    text: widget.viewModel.state.email,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit = widget.viewModel.state.canSubmitEmail;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bem-vindo ao duni',
                  style: DuniTypography.heading2.copyWith(
                    color: DuniColors.purple500,
                  ),
                ),
                const SizedBox(height: DuniSpacing.xxs),
                Text(
                  'Use o e-mail corporativo que recebeu o convite.',
                  style: DuniTypography.bodySmall.copyWith(
                    color: DuniColors.purpleGray100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: DuniSpacing.lg),
                  child: DuniTextField(
                    label: 'E-mail corporativo',
                    hintText: 'email@empresa.com',
                    controller: _controller,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: widget.viewModel.updateEmail,
                  ),
                ),
              ],
            ),
          ),
        ),
        DuniButton(
          label: 'Continuar',
          state: canSubmit ? DuniButtonState.enabled : DuniButtonState.disabled,
          onPressed: canSubmit ? widget.viewModel.submitEmail : null,
        ),
        const SizedBox(height: DuniSpacing.xs),
        Text(
          'Não recebeu convite? Fale com o RH da sua empresa.',
          textAlign: TextAlign.center,
          style: DuniTypography.bodySmall.copyWith(
            color: DuniColors.purpleGray100,
          ),
        ),
      ],
    );
  }
}
