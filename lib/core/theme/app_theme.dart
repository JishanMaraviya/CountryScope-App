import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const _seed = Color(0xFF2B6EF3);

  static ColorScheme lightScheme([ColorScheme? dynamicScheme]) =>
      dynamicScheme ?? ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.light);

  static ColorScheme darkScheme([ColorScheme? dynamicScheme]) =>
      dynamicScheme ?? ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark);

  static ThemeData build(ColorScheme scheme) => ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: scheme.surface,
        appBarTheme: AppBarTheme(
          centerTitle: false,
          backgroundColor: scheme.surface,
          surfaceTintColor: Colors.transparent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: scheme.surfaceContainerHighest.withValues(alpha: .55),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      );
}
