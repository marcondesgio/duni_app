import 'package:flutter/foundation.dart';

import 'splash_state.dart';

/// ViewModel da tela de Splash.
///
/// Placeholder: hoje só simula um carregamento breve. Quando existir uma
/// checagem real de sessão (ex.: usuário já autenticado), ela entra aqui,
/// antes de marcar `ready`.
class SplashViewmodal extends ChangeNotifier {
  SplashState _state = const SplashState();
  SplashState get state => _state;

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));
    _state = _state.copyWith(status: SplashStatus.ready);
    notifyListeners();
  }
}
