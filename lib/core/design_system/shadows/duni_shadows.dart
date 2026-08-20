import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/widgets.dart';

/// Sombras do DUNI Design System.
///
/// Placeholder: a documentação não especifica blur/offset/opacidade exatos.
/// Os valores abaixo seguem uma elevação suave e devem ser confirmados com
/// o Figma.
abstract final class DuniShadows {
  static final card = [
    BoxShadow(
      color: DuniColors.gray100,
      blurRadius: DuniSpacing.xxs,
      offset: const Offset(2, 4),
    ),
  ];

  static final raised = [
    BoxShadow(
      color: DuniColors.purple100,
      blurRadius: DuniSpacing.lg,
      offset: const Offset(0, 8),
    ),
  ];
}
