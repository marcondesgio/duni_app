import 'package:flutter/widgets.dart';

import 'duni_breakpoints.dart';

/// Utilitário de responsividade do DUNI Design System.
///
/// Evita checagens de largura fixa espalhadas pelas telas (ex.: `if (width
/// == 390)`) — sempre resolver o [DuniBreakpoint] atual a partir daqui.
abstract final class DuniResponsive {
  static DuniBreakpoint of(BuildContext context) =>
      DuniBreakpoint.fromWidth(MediaQuery.sizeOf(context).width);

  static bool isMobile(BuildContext context) => of(context) == DuniBreakpoint.mobile;

  static bool isTablet(BuildContext context) => of(context) == DuniBreakpoint.tablet;

  static bool isDesktop(BuildContext context) => of(context) == DuniBreakpoint.desktop;
}

/// Constrói um widget diferente para cada [DuniBreakpoint], escolhendo o
/// builder mais específico disponível para a largura atual (com fallback
/// para mobile).
class DuniResponsiveBuilder extends StatelessWidget {
  const DuniResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;

  @override
  Widget build(BuildContext context) {
    switch (DuniResponsive.of(context)) {
      case DuniBreakpoint.desktop:
        return (desktop ?? tablet ?? mobile)(context);
      case DuniBreakpoint.tablet:
        return (tablet ?? mobile)(context);
      case DuniBreakpoint.mobile:
        return mobile(context);
    }
  }
}
