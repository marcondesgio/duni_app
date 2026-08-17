import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

import 'onboarding_state.dart';
import 'onboarding_viewmodal.dart';
import 'widgets/widgets.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final _viewModel = OnboardingViewmodal(onFinished: _handleFinished);

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _handleFinished() {
    // Placeholder: ainda não existe uma rota Home no app — sinaliza a
    // conclusão do onboarding até ela existir.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Onboarding concluído! (Home ainda não implementada)'),
      ),
    );
  }

  /// Etapas de configuração de perfil (nome/interesses/foto) não usam AppBar
  /// — só o [DuniOnboardingProgress] no topo, já renderizado por cada step.
  static const _stepsWithoutAppBar = {
    OnboardingStep.name,
    OnboardingStep.interests,
    OnboardingStep.photo,
  };

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        final step = _viewModel.state.step;
        final showAppBar = !_stepsWithoutAppBar.contains(step);

        // Nas etapas sem AppBar (name/interests/photo) também bloqueamos o
        // "voltar" nativo (gesto/botão do sistema) — não há afordância de
        // voltar nessas etapas, então o Navigator também não deve.
        return PopScope(
          canPop: showAppBar,
          child: Scaffold(
            backgroundColor: DuniColors.white,
            appBar: showAppBar
                ? AppBar(
                    backgroundColor: DuniColors.white,
                    elevation: 0,
                    leading: step == OnboardingStep.login
                        ? null
                        : IconButton(
                            icon: Icon(Icons.arrow_back, size: DuniSpacing.lg),
                            onPressed: _viewModel.goBack,
                            color: DuniColors.purple500,
                          ),
                  )
                : null,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(DuniSpacing.lg),
                child: switch (step) {
                  OnboardingStep.login => OnboardingLoginStep(
                    viewModel: _viewModel,
                  ),
                  OnboardingStep.code => OnboardingCodeStep(
                    viewModel: _viewModel,
                  ),
                  OnboardingStep.name => OnboardingNameStep(
                    viewModel: _viewModel,
                  ),
                  OnboardingStep.interests => OnboardingInterestsStep(
                    viewModel: _viewModel,
                  ),
                  OnboardingStep.photo => OnboardingPhotoStep(
                    viewModel: _viewModel,
                  ),
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
