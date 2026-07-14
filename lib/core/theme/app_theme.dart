import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract final class AppTheme {
  static const _primaryAccent = Color(0xFF007AFF);
  static const _success = Color(0xFF34C759);
  static const _warning = Color(0xFFFF9F0A);
  static const _danger = Color(0xFFFF3B30);
  
  static const _lightBg = Color(0xFFFFFFFF);
  static const _lightSecondaryBg = Color(0xFFF8F8FA);
  static const _lightPrimaryText = Color(0xFF111111);
  static const _lightSecondaryText = Color(0xFF6B7280);
  static const _lightBorder = Color(0xFFECECEC);

  static const _darkBg = Color(0xFF000000);
  static const _darkSecondaryBg = Color(0xFF1C1C1E);
  static const _darkPrimaryText = Color(0xFFFFFFFF);
  static const _darkSecondaryText = Color(0xFF8E8E93);
  static const _darkBorder = Color(0xFF38383A);

  static ColorScheme lightScheme([ColorScheme? dynamicScheme]) => ColorScheme(
        brightness: Brightness.light,
        primary: _primaryAccent,
        onPrimary: Colors.white,
        secondary: _primaryAccent,
        onSecondary: Colors.white,
        error: _danger,
        onError: Colors.white,
        surface: _lightBg,
        onSurface: _lightPrimaryText,
        surfaceContainerHighest: _lightSecondaryBg,
        onSurfaceVariant: _lightSecondaryText,
        outline: _lightBorder,
      );

  static ColorScheme darkScheme([ColorScheme? dynamicScheme]) => ColorScheme(
        brightness: Brightness.dark,
        primary: _primaryAccent,
        onPrimary: Colors.white,
        secondary: _primaryAccent,
        onSecondary: Colors.white,
        error: _danger,
        onError: Colors.white,
        surface: _darkBg,
        onSurface: _darkPrimaryText,
        surfaceContainerHighest: _darkSecondaryBg,
        onSurfaceVariant: _darkSecondaryText,
        outline: _darkBorder,
      );

  static TextTheme _buildTextTheme(ColorScheme scheme) {
    return TextTheme(
      headlineLarge: TextStyle(color: scheme.onSurface, fontSize: 34, fontWeight: FontWeight.bold, letterSpacing: 0.4),
      headlineMedium: TextStyle(color: scheme.onSurface, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 0.35),
      headlineSmall: TextStyle(color: scheme.onSurface, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 0.35),
      titleLarge: TextStyle(color: scheme.onSurface, fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 0.35),
      titleMedium: TextStyle(color: scheme.onSurface, fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: -0.4),
      titleSmall: TextStyle(color: scheme.onSurface, fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: -0.2),
      bodyLarge: TextStyle(color: scheme.onSurface, fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: -0.4),
      bodyMedium: TextStyle(color: scheme.onSurface, fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: -0.2),
      bodySmall: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: -0.1),
      labelLarge: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: -0.1),
      labelMedium: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0),
      labelSmall: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    );
  }

  static ThemeData build(ColorScheme scheme) => ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: scheme.surface,
        textTheme: _buildTextTheme(scheme),
        appBarTheme: AppBarTheme(
          centerTitle: false,
          backgroundColor: scheme.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          systemOverlayStyle: scheme.brightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          titleTextStyle: _buildTextTheme(scheme).headlineSmall,
          iconTheme: IconThemeData(color: scheme.primary),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: scheme.surfaceContainerHighest,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: scheme.primary.withValues(alpha: 0.5), width: 1)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: TextStyle(color: scheme.onSurfaceVariant, fontSize: 17),
        ),
        cardTheme: CardThemeData(
          color: scheme.surface,
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: scheme.outline.withValues(alpha: 0.5), width: 1),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: scheme.surface.withValues(alpha: 0.8),
          elevation: 0,
          selectedItemColor: scheme.primary,
          unselectedItemColor: scheme.onSurfaceVariant,
        ),
      );
}
