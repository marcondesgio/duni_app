import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../shared/shared.dart';
import 'splash_state.dart';
import 'splash_viewmodal.dart';

/// Placeholder: a documentação não descreve uma tela de Splash — fundo com
/// o gradiente de marca e o wordmark "DUNI" até isso ser confirmado com o
/// Figma.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final _viewModel = SplashViewmodal();

  @override
  void initState() {
    super.initState();
    _viewModel.init().then((_) {
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacementNamed(OnboardingRouter.onboardingPage);
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: DuniGradients.navy),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'DUNI',
                style: DuniTypography.display.copyWith(color: Colors.white),
              ),
              const SizedBox(height: DuniSpacing.xl),
              ListenableBuilder(
                listenable: _viewModel,
                builder: (context, _) {
                  return _viewModel.state.status == SplashStatus.loading
                      ? LoadingAnimationWidget.progressiveDots(
                          color: Colors.white,
                          size: 32,
                        )
                      : const SizedBox(height: 32);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
