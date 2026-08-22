import 'package:flutter/material.dart';

/// Controla o modo claro/escuro do DUNI — estado do app inteiro, não de uma
/// tela específica, por isso vive como singleton em vez de seguir o padrão
/// ChangeNotifier por tela (`*Viewmodal`) usado no resto do projeto.
///
/// Sem persistência ainda (mesmo padrão "sem backend" das outras features):
/// volta para o modo claro a cada reinício do app.
class DuniThemeController extends ChangeNotifier {
  DuniThemeController._();

  static final instance = DuniThemeController._();

  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;
  bool get isDark => _mode == ThemeMode.dark;

  void setDark(bool value) {
    final next = value ? ThemeMode.dark : ThemeMode.light;
    if (next == _mode) return;
    _mode = next;
    notifyListeners();
  }

  void toggle() => setDark(!isDark);
}

/// Força a reconstrução completa de [child] sempre que
/// [DuniThemeController.instance] muda.
///
/// Necessário porque os tokens de cor do Design System (`DuniColors`) são
/// getters estáticos, não valores lidos via `Theme.of(context)` — nada os
/// reavalia automaticamente quando o modo muda. Cada rota central
/// (`AppRouter.onGenerateRoute`) envolve sua tela com este widget para que
/// toda a árvore da tela seja reconstruída e releia os tokens atuais.
///
/// O `ListenableBuilder` sozinho não bastaria: como [child] é o mesmo
/// widget (a mesma instância) em toda reconstrução, o Flutter reconhece
/// `child.widget == newWidget` e pula o rebuild daquele galho da árvore —
/// só o próprio `DuniThemeScope` reconstruiria, sem efeito nenhum na tela
/// por baixo. O `KeyedSubtree` com uma key que muda por modo força o
/// Flutter a tratar isso como um widget diferente e remontar a subárvore
/// inteira (perde estado local da tela ao alternar o tema — aceitável, já
/// que nenhuma tela persiste estado real ainda).
class DuniThemeScope extends StatelessWidget {
  const DuniThemeScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: DuniThemeController.instance,
      builder: (context, _) => KeyedSubtree(
        key: ValueKey(DuniThemeController.instance.mode),
        child: child,
      ),
    );
  }
}
