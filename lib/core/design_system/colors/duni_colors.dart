import 'package:flutter/widgets.dart';

import '../theme/duni_theme_controller.dart';

/// Paleta de cores oficial do DUNI Design System.
///
/// Valores alinhados ao "Color System" (não às variações soltas do Figma —
/// ver seção 7 da documentação, que resolve a divergência a favor destes
/// tokens).
///
/// Modo claro/escuro: a maioria dos tokens abaixo é usada em mais de um
/// papel (ex.: `purple500` ora como texto sobre uma superfície clara, ora
/// como texto/ícone sobre o gradiente de marca; `white` ora como fundo de
/// card, ora como texto sobre um fundo colorido) — inverter o token
/// literalmente quebraria um dos dois papéis. Por isso os tokens de marca
/// (purple200/300/400, teal, yellow, pink, notificações) e os usos "em cima
/// do gradiente/badge" continuam fixos, e o papel que realmente precisa
/// inverter no escuro (texto e fundo sobre superfície neutra) ganhou tokens
/// semânticos próprios (`background`/`surface`/`textPrimary`/
/// `textSecondary`/`textTertiary`, no fim da classe). Os tons de cinza
/// (`gray50`..`gray300`) não têm esse conflito — só aparecem como
/// fundo/borda em todo o app — então eles mesmos viraram getters
/// sensíveis ao modo, sem precisar de um token semântico separado.
abstract final class DuniColors {
  static bool get _isDark => DuniThemeController.instance.isDark;

  ///Purple
  static const purple500 = Color(0xFF1B1240);
  static const purple400 = Color(0xFF3D2A7A);
  static const purple300 = Color(0xFF5B21B6);
  static const purple200 = Color(0xFF7C3AED); //Principal
  static const purple100 = Color(0xFFC4B5FD);
  static const purple50 = Color(0xFFEDE9F7);

  ///Purple Gray
  static const purpleGray100 = Color(0xFF6B6478);
  static const purpleGray50 = Color(0xFFA99FC4);

  ///Gray — sensíveis ao modo (só usados como fundo/borda, nunca como texto).
  static Color get gray300 =>
      _isDark ? const Color(0xFF6E67A0) : const Color(0xFFA8A29E);
  static Color get gray200 =>
      _isDark ? const Color(0xFF3A3568) : const Color(0xFFE7E1D8);
  static Color get gray100 =>
      _isDark ? const Color(0xFF2A2554) : const Color(0xFFF5F2EC);
  static Color get gray50 =>
      _isDark ? const Color(0xFF201B42) : const Color(0xFFFBFAF8);

  ///Notifications
  static const success = Color(0xFF3F6B64);
  static const warning = Color(0xFF92400E);
  static const error = Color(0xFF8F0606);

  ///Teal
  static const teal200 = Color(0xFF2AC9B7);
  static const teal100 = Color(0xFFC6EFE8);
  static const teal50 = Color(0xFFF0FBF9);

  ///Yellow
  static const yellow300 = Color(0xFFF59E0B);
  static const yellow200 = Color(0xFFFBBF24);
  static const yellow100 = Color(0xFFFDE68A);
  static const yellow50 = Color(0xFFFFFBEB);

  ///Red
  static const red100 = Color(0xFFEFC6C6);
  static const red50 = Color(0xFFFBF4F4);

  ///Pink
  static const pink = Color(0xFFEC3F8C);

  ///White
  static const white = Color(0xFFFFFFFF);

  ///Black
  static const black = Color(0xFF000000);

  ///Semânticos (fundo/texto sobre superfície neutra — únicos papéis que
  ///invertem entre claro/escuro; ver nota da classe).
  static Color get background =>
      _isDark ? const Color(0xFF14102B) : white;
  static Color get surface =>
      _isDark ? const Color(0xFF1F1B3D) : white;
  static Color get textPrimary =>
      _isDark ? const Color(0xFFF3F0FA) : purple500;
  static Color get textSecondary =>
      _isDark ? const Color(0xFFAFA6C9) : purpleGray100;
  static Color get textTertiary =>
      _isDark ? const Color(0xFF9089B3) : purpleGray50;
}
