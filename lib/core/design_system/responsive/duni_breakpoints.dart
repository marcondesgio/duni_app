/// Breakpoints do DUNI Design System.
///
/// Base de design: Mobile 390px / Web 1180px (ver cabeçalho da documentação).
enum DuniBreakpoint {
  mobile,
  tablet,
  desktop;

  static const mobileMax = 599.0;
  static const tabletMax = 1179.0;

  static DuniBreakpoint fromWidth(double width) {
    if (width <= mobileMax) return DuniBreakpoint.mobile;
    if (width <= tabletMax) return DuniBreakpoint.tablet;
    return DuniBreakpoint.desktop;
  }
}
