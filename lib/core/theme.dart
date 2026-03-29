import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color background = Color(0xFF0A0B10);
  static const Color surface = Color(0xFF13151A);
  static const Color surfaceHighlight = Color(0xFF1C1E26);
  
  static const Color cyanAccent = Color(0xFF00FFD1);
  static const Color cyanMuted = Color(0xFF007A65);
  
  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF475569);
  
  static const Color successGreen = Color(0xFF10B981);
  static const Color borderSide = Color(0xFF1E293B);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: cyanAccent,
      canvasColor: surface,
      colorScheme: const ColorScheme.dark(
        primary: cyanAccent,
        surface: surface,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(fontSize: 72, fontWeight: FontWeight.w800, color: textPrimary, letterSpacing: -2.0, height: 1.1),
        displayMedium: GoogleFonts.inter(fontSize: 56, fontWeight: FontWeight.w800, color: textPrimary, letterSpacing: -1.5, height: 1.1),
        displaySmall: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.bold, color: textPrimary, letterSpacing: -1.0, height: 1.2),
        headlineMedium: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600, color: textPrimary, letterSpacing: -0.5),
        titleLarge: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: textPrimary),
        titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: textPrimary),
        bodyLarge: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.normal, color: textSecondary, height: 1.6),
        bodyMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.normal, color: textSecondary, height: 1.6),
        labelLarge: GoogleFonts.robotoMono(fontSize: 14, fontWeight: FontWeight.w600, color: cyanAccent, letterSpacing: 1.5),
        labelMedium: GoogleFonts.robotoMono(fontSize: 12, fontWeight: FontWeight.w500, color: textMuted, letterSpacing: 1.5),
        labelSmall: GoogleFonts.robotoMono(fontSize: 10, fontWeight: FontWeight.w500, color: textMuted, letterSpacing: 1.5),
      ),
    );
  }
}
