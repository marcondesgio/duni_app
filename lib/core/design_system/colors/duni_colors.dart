import 'package:flutter/widgets.dart';

/// Paleta de cores oficial do DUNI Design System.
///
/// Valores alinhados ao "Color System" (não às variações soltas do Figma —
/// ver seção 7 da documentação, que resolve a divergência a favor destes
/// tokens).
abstract final class DuniColors {
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

  ///Gray
  static const gray300 = Color(0xFFA8A29E);
  static const gray200 = Color(0xFFE7E1D8);
  static const gray100 = Color(0xFFF5F2EC);
  static const gray50 = Color(0xFFFBFAF8);

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
}
