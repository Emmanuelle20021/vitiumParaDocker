import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitium_app/constantes/constantes.dart';

var tema = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: customColor,
    backgroundColor: background,
    accentColor: accent,
  ),
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: primary),
    unselectedIconTheme: IconThemeData(color: icon),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(17),
      ),
    ),
  ),
);
