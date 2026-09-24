import 'package:flutter/material.dart';

/// Paleta institucional del curso (misma usada en los guiones y los scripts
/// de Gamma): navy como color principal, acento en rojo ladrillo.
const Color kNavy = Color(0xFF1F3864);
const Color kAccent = Color(0xFFB03A2E);
const Color kNavySoft = Color(0xFFE7ECF5);

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kNavy,
      primary: kNavy,
      secondary: kAccent,
    ),
  );
  return base.copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: kNavy,
      foregroundColor: Colors.white,
      centerTitle: false,
    ),
    scaffoldBackgroundColor: const Color(0xFFF7F8FA),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kNavy,
        foregroundColor: Colors.white,
      ),
    ),
  );
}
