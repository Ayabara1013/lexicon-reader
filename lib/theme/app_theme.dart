import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Synthwave/Cyberpunk color palette
class SynthwaveColors {
  // Background colors
  static const deepPurple = Color(0xFF0A0A1F);
  static const darkPurple = Color(0xFF1A1A2E);
  static const mediumPurple = Color(0xFF16213E);

  // Neon accent colors
  static const neonPink = Color(0xFFFF00FF);
  static const neonCyan = Color(0xFF00FFFF);
  static const electricPurple = Color(0xFFBD00FF);
  static const neonBlue = Color(0xFF0066FF);

  // Additional colors
  static const softGlow = Color(0xFFFF00FF);
  static const textPrimary = Color(0xFFE0E0E0);
  static const textSecondary = Color(0xFFB0B0B0);
  static const textDimmed = Color(0xFF808080);

  // Gradient colors
  static const gradientStart = Color(0xFFBD00FF);
  static const gradientEnd = Color(0xFFFF00FF);
}

/// Synthwave theme configuration
class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: SynthwaveColors.neonPink,
        secondary: SynthwaveColors.neonCyan,
        tertiary: SynthwaveColors.electricPurple,
        surface: SynthwaveColors.darkPurple,
        background: SynthwaveColors.deepPurple,
        error: Color(0xFFFF0055),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: SynthwaveColors.textPrimary,
        onBackground: SynthwaveColors.textPrimary,
      ),

      // Scaffold background
      scaffoldBackgroundColor: SynthwaveColors.deepPurple,

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: SynthwaveColors.darkPurple,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.orbitron(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: SynthwaveColors.neonPink,
          letterSpacing: 2,
          shadows: [
            const Shadow(
              color: SynthwaveColors.neonPink,
              blurRadius: 10,
            ),
          ],
        ),
        iconTheme: const IconThemeData(
          color: SynthwaveColors.neonCyan,
        ),
      ),

      // Card theme
      cardTheme: CardTheme(
        color: SynthwaveColors.darkPurple,
        elevation: 8,
        shadowColor: SynthwaveColors.neonPink.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: SynthwaveColors.electricPurple.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),

      // Text theme - optimized for reading
      textTheme: TextTheme(
        // Display styles (titles, headers)
        displayLarge: GoogleFonts.orbitron(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: SynthwaveColors.neonPink,
          letterSpacing: 1.5,
        ),
        displayMedium: GoogleFonts.orbitron(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: SynthwaveColors.neonCyan,
          letterSpacing: 1.2,
        ),
        displaySmall: GoogleFonts.orbitron(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: SynthwaveColors.electricPurple,
          letterSpacing: 1,
        ),

        // Headline styles
        headlineLarge: GoogleFonts.rajdhani(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: SynthwaveColors.textPrimary,
          letterSpacing: 0.5,
        ),
        headlineMedium: GoogleFonts.rajdhani(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: SynthwaveColors.textPrimary,
        ),
        headlineSmall: GoogleFonts.rajdhani(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: SynthwaveColors.textSecondary,
        ),

        // Body text - optimized for reading content
        bodyLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: SynthwaveColors.textPrimary,
          height: 1.8,
          letterSpacing: 0.3,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: SynthwaveColors.textPrimary,
          height: 1.7,
          letterSpacing: 0.25,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: SynthwaveColors.textSecondary,
          height: 1.6,
        ),

        // Label styles
        labelLarge: GoogleFonts.rajdhani(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: SynthwaveColors.neonCyan,
          letterSpacing: 1,
        ),
        labelMedium: GoogleFonts.rajdhani(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: SynthwaveColors.textSecondary,
          letterSpacing: 0.8,
        ),
        labelSmall: GoogleFonts.rajdhani(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: SynthwaveColors.textDimmed,
          letterSpacing: 0.5,
        ),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: SynthwaveColors.darkPurple,
        selectedItemColor: SynthwaveColors.neonPink,
        unselectedItemColor: SynthwaveColors.textDimmed,
        elevation: 16,
        type: BottomNavigationBarType.fixed,
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SynthwaveColors.electricPurple,
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: SynthwaveColors.electricPurple.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.rajdhani(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: SynthwaveColors.neonCyan,
        size: 24,
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: SynthwaveColors.electricPurple.withOpacity(0.3),
        thickness: 1,
        space: 1,
      ),
    );
  }

  /// Neon glow box decoration
  static BoxDecoration neonGlowBox({
    Color glowColor = SynthwaveColors.neonPink,
    double blurRadius = 20,
    double spreadRadius = 2,
  }) {
    return BoxDecoration(
      color: SynthwaveColors.darkPurple,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: glowColor.withOpacity(0.5),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: glowColor.withOpacity(0.3),
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
        ),
      ],
    );
  }

  /// Gradient decoration
  static BoxDecoration neonGradient({
    List<Color>? colors,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: colors ?? [
          SynthwaveColors.electricPurple,
          SynthwaveColors.neonPink,
        ],
        begin: begin,
        end: end,
      ),
      borderRadius: BorderRadius.circular(16),
    );
  }

  /// Text shadow for neon effect
  static List<Shadow> neonTextShadow({
    Color color = SynthwaveColors.neonPink,
    double blurRadius = 10,
  }) {
    return [
      Shadow(
        color: color,
        blurRadius: blurRadius,
      ),
      Shadow(
        color: color.withOpacity(0.5),
        blurRadius: blurRadius * 2,
      ),
    ];
  }
}
