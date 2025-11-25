import 'package:flutter/material.dart';

class AppTheme {
  // Colores base — ajústalos según prefieras
  static const Color primary = Color(0xFF2E7D32); // green 700
  static const Color accent = Color(0xFFFFC107);
  static const Color background = Color(0xFFF6F8FA);
  static const Color surface = Colors.white;

  static ThemeData light() {
    final base = ThemeData.light();
    return base.copyWith(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primary),
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      textTheme: base.textTheme.apply(
        // Si añades una fuente en pubspec, cámbiala aquí
        fontFamily: 'Inter',
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        ),
      ),
      // Evitamos asignar CardTheme directamente para compatibilidad entre versiones.
      cardColor: surface,
      // Puedes controlar la forma de cards globalmente así:
      dividerColor: base.dividerColor,
      // Si más adelante quieres custom CardTheme, actualiza según tu versión de Flutter.
    );
  }
}