import 'package:flutter/widgets.dart';

import '../colors/duni_colors.dart';

/// Sombras do DUNI Design System.
///
/// Placeholder: a documentação não especifica blur/offset/opacidade exatos.
/// Os valores abaixo seguem uma elevação suave e devem ser confirmados com
/// o Figma.
abstract final class DuniShadows {
  static final card = [
    BoxShadow(
      color: DuniColors.purple500.withAlpha(20), // ~8% de opacidade
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static final raised = [
    BoxShadow(
      color: DuniColors.purple500.withAlpha(31), // ~12% de opacidade
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];
}
