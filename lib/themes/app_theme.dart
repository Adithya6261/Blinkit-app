import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color blinkitGreen = Color(0xFF00A699);
  static const Color blinkitYellow = Color(0xFFFFE600);

  static const Color headerPink = Color(0xFFFFE8ED);
  static const Color headerPinkDark = Color(0xFFFFCEDA);

  static final TextTheme textTheme = GoogleFonts.interTextTheme().apply(
    bodyColor: Colors.black87,
    displayColor: Colors.black87,
  );

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(seedColor: blinkitGreen),
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );
}
