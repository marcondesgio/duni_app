import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/duni_colors.dart';
import '../radius/duni_radius.dart';
import '../spacing/duni_spacing.dart';
import '../typography/duni_typography.dart';

/// Tema Flutter oficial do DUNI, construído inteiramente a partir dos tokens
/// do Design System (cores, tipografia, espaçamento, radius).
abstract final class DuniTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: DuniColors.purple200,
      brightness: Brightness.light,
      primary: DuniColors.purple200,
      secondary: DuniColors.teal200,
      error: DuniColors.error,
      surface: DuniColors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: DuniColors.white,
      // Base Poppins para qualquer papel de texto não coberto explicitamente
      // abaixo, sobrescrita pelos estilos semânticos do DuniTypography.
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: DuniTypography.display,
        headlineLarge: DuniTypography.heading1,
        headlineMedium: DuniTypography.heading2,
        headlineSmall: DuniTypography.heading3,
        bodyLarge: DuniTypography.bodyLarge,
        bodyMedium: DuniTypography.body,
        bodySmall: DuniTypography.bodySmall,
        labelLarge: DuniTypography.button,
        labelMedium: DuniTypography.label,
        labelSmall: DuniTypography.caption,
      ),
      dividerColor: DuniColors.gray100,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DuniColors.purple200,
          foregroundColor: Colors.white,
          textStyle: DuniTypography.button,
          padding: const EdgeInsets.symmetric(
            horizontal: DuniSpacing.lg,
            vertical: DuniSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DuniRadius.pill),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DuniSpacing.md,
          vertical: DuniSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DuniRadius.medium),
          borderSide: BorderSide(color: DuniColors.gray100),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DuniRadius.medium),
          borderSide: BorderSide(color: DuniColors.gray100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DuniRadius.medium),
          borderSide: BorderSide(color: DuniColors.gray100, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DuniRadius.medium),
          borderSide: const BorderSide(color: DuniColors.error),
        ),
      ),
    );
  }

  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: DuniColors.purple200,
      brightness: Brightness.dark,
      primary: DuniColors.purple200,
      secondary: DuniColors.teal200,
      error: DuniColors.error,
      surface: DuniColors.surface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: DuniColors.background,
      // Base Poppins para qualquer papel de texto não coberto explicitamente
      // abaixo, sobrescrita pelos estilos semânticos do DuniTypography.
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: DuniTypography.display,
        headlineLarge: DuniTypography.heading1,
        headlineMedium: DuniTypography.heading2,
        headlineSmall: DuniTypography.heading3,
        bodyLarge: DuniTypography.bodyLarge,
        bodyMedium: DuniTypography.body,
        bodySmall: DuniTypography.bodySmall,
        labelLarge: DuniTypography.button,
        labelMedium: DuniTypography.label,
        labelSmall: DuniTypography.caption,
      ),
      dividerColor: DuniColors.gray100,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DuniColors.purple200,
          foregroundColor: Colors.white,
          textStyle: DuniTypography.button,
          padding: const EdgeInsets.symmetric(
            horizontal: DuniSpacing.lg,
            vertical: DuniSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DuniRadius.pill),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DuniColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DuniSpacing.md,
          vertical: DuniSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DuniRadius.medium),
          borderSide: BorderSide(color: DuniColors.gray100),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DuniRadius.medium),
          borderSide: BorderSide(color: DuniColors.gray100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DuniRadius.medium),
          borderSide: BorderSide(color: DuniColors.gray100, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DuniRadius.medium),
          borderSide: const BorderSide(color: DuniColors.error),
        ),
      ),
    );
  }
}
