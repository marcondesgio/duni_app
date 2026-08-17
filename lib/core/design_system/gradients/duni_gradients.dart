import 'package:flutter/widgets.dart';

import '../colors/duni_colors.dart';

/// Gradientes do DUNI Design System.
///
/// Nenhum componente deve declarar seu próprio gradiente — reutilizar os
/// tokens abaixo.
abstract final class DuniGradients {
  static const purple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [DuniColors.purple200, DuniColors.purple300],
  );

  static const navy = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [DuniColors.purple500, DuniColors.purple300],
  );

  static const avatar = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [DuniColors.purple200, DuniColors.teal200],
  );
}
