import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../onboarding_viewmodal.dart';

/// Placeholder: a documentação não detalha esta tela (só a menciona na
/// ordem da seção 43 — "Login → Código → Onboarding"). Estrutura genérica de
/// verificação por código até haver especificação/Figma confirmados.
class OnboardingCodeStep extends StatefulWidget {
  const OnboardingCodeStep({super.key, required this.viewModel});

  final OnboardingViewmodal viewModel;

  @override
  State<OnboardingCodeStep> createState() => _OnboardingCodeStepState();
}

class _OnboardingCodeStepState extends State<OnboardingCodeStep> {
  @override
  Widget build(BuildContext context) {
    final state = widget.viewModel.state;
    final canSubmit = state.canSubmitCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Expanded + SingleChildScrollView (em vez de Spacer direto no
        // Column): quando o teclado abre e some espaço disponível, o
        // conteúdo aqui dentro rola em vez de causar overflow — só o botão
        // abaixo fica realmente fixo.
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Digite seu código',
                  style: DuniTypography.heading2.copyWith(
                    color: DuniColors.textPrimary,
                  ),
                ),
                const SizedBox(height: DuniSpacing.xxs),
                Text(
                  'Enviamos 6 dígitos para',
                  style: DuniTypography.bodySmall.copyWith(
                    color: DuniColors.textSecondary,
                  ),
                ),
                Text(
                  state.email,
                  style: DuniTypography.label.copyWith(
                    color: DuniColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: DuniSpacing.lg),
                DuniOtpField(
                  length: 6,
                  onChanged: widget.viewModel.updateCode,
                  onCompleted: (_) => widget.viewModel.submitCode(),
                ),
              ],
            ),
          ),
        ),
        DuniButton(
          label: 'Entrar',
          state: canSubmit ? DuniButtonState.enabled : DuniButtonState.disabled,
          onPressed: canSubmit ? widget.viewModel.submitCode : null,
        ),
      ],
    );
  }
}
