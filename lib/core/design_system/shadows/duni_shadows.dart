import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/widgets.dart';

/// Sombras do DUNI Design System.
///
/// Placeholder: a documentação não especifica blur/offset/opacidade exatos.
/// Os valores abaixo seguem uma elevação suave e devem ser confirmados com
/// o Figma.
abstract final class DuniShadows {
  // Getters, não `static final`: um campo `final` calcularia a sombra uma
  // única vez e a manteria congelada com a cor do modo claro/escuro que
  // estava ativo no primeiro acesso, ignorando trocas de tema depois disso.
  static List<BoxShadow> get card => [
    BoxShadow(
      color: DuniColors.gray200,
      blurRadius: DuniSpacing.xxs,
      offset: const Offset(0, 0),
    ),
  ];

  static List<BoxShadow> get raised => [
    BoxShadow(
      color: DuniColors.purple100,
      blurRadius: DuniSpacing.lg,
      offset: const Offset(0, 8),
    ),
  ];
}
