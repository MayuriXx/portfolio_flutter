import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palette de couleurs du design system.
///
/// Cinq teintes de vert sauge (`c1` → `c5`) et leurs alias sémantiques
/// (`bg`, `ink`, `accent`, `border`, etc.).
class AppColors {
  AppColors._();

  // Palette
  static const c1 = Color(0xFF6B9080); // vert sauge foncé
  static const c2 = Color(0xFFA4C3B2); // vert sauge moyen
  static const c3 = Color(0xFFCCE3DE); // vert menthe doux
  static const c4 = Color(0xFFEAF4F4); // blanc bleuté
  static const c5 = Color(0xFFF6FFF8); // blanc cassé vert

  // Sémantique
  static const bg = c5;
  static const surface = Colors.white;
  static const border = c3;
  static const ink = Color(0xFF1E2A25);
  static const inkMid = Color(0xFF4A6358);
  static const inkLight = Color(0xFF8AAB99);
  static const accent = c1;
  static const accentMid = c2;
  static const accentSoft = c3;
  static const accentPale = c4;
}

/// Échelons d'espacement utilisés pour les paddings et les gaps.
///
/// Valeurs en pixels : `xs`=8, `sm`=16, `md`=24, `lg`=48, `xl`=80, `xxl`=120.
class AppSpacing {
  AppSpacing._();

  static const xs = 8.0;
  static const sm = 16.0;
  static const md = 24.0;
  static const lg = 48.0;
  static const xl = 80.0;
  static const xxl = 120.0;
}

/// Rayons de bordure réutilisables.
class AppRadius {
  AppRadius._();

  static const sm = Radius.circular(6);
  static const md = Radius.circular(12);
  static const lg = Radius.circular(20);
  static const full = Radius.circular(100);
}

/// Styles typographiques du design system.
///
/// Titres en **Syne** (display*, titleLarge) ;
/// corps de texte en **Instrument Sans** (body*, label, tag).
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get displayLarge => GoogleFonts.syne(
    fontSize: 80,
    fontWeight: FontWeight.w800,
    letterSpacing: -3.0,
    height: 0.92,
    color: AppColors.ink,
  );

  static TextStyle get displayMedium => GoogleFonts.syne(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.5,
    height: 1.05,
    color: AppColors.ink,
  );

  static TextStyle get displaySmall => GoogleFonts.syne(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.0,
    height: 1.1,
    color: AppColors.ink,
  );

  static TextStyle get titleLarge => GoogleFonts.syne(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: AppColors.ink,
  );

  static TextStyle get bodyLarge => GoogleFonts.instrumentSans(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 1.7,
    color: AppColors.inkMid,
  );

  static TextStyle get bodyMedium => GoogleFonts.instrumentSans(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.65,
    color: AppColors.inkMid,
  );

  static TextStyle get bodySmall => GoogleFonts.instrumentSans(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.inkMid,
  );

  static TextStyle get label => GoogleFonts.instrumentSans(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.2,
    color: AppColors.accent,
  );

  static TextStyle get tag => GoogleFonts.instrumentSans(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.inkMid,
  );
}

/// Thème Material 3 de l'application.
///
/// Utilise [AppColors] comme `colorScheme` et Instrument Sans comme
/// police de base via [GoogleFonts.instrumentSansTextTheme].
class AppTheme {
  AppTheme._();

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: ColorScheme.light(
      primary: AppColors.accent,
      secondary: AppColors.accentMid,
      surface: AppColors.surface,
    ),
    textTheme: GoogleFonts.instrumentSansTextTheme(),
  );
}
