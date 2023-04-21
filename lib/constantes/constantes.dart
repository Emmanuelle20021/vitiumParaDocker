import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Constantes {
  Color azulVitium = const Color(0xff003399);
  Color resaltado = const Color(0xff4274FC);
  Color naranja = const Color(0xffFCA34B);

  TextStyle splashNegro() {
    return TextStyle(
      fontFamily: GoogleFonts.comfortaa().fontFamily,
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: const Color(0xff000000),
    );
  }

  TextStyle splashNaranja() {
    return TextStyle(
      fontFamily: GoogleFonts.comfortaa().fontFamily,
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: const Color(0xffFCA34B),
    );
  }

  TextStyle tituloGris() {
    return TextStyle(
      fontFamily: GoogleFonts.comfortaa().fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: const Color(0xff383838),
    );
  }

  TextStyle tituloAzul() {
    return TextStyle(
      fontFamily: GoogleFonts.comfortaa().fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: const Color(0xff254AB0),
    );
  }

  TextStyle popUp() {
    return TextStyle(
      fontFamily: GoogleFonts.comfortaa().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: const Color(0xff003399),
    );
  }

  ButtonStyle boton() {
    return ButtonStyle(
        shape: MaterialStateProperty.all(
            BorderRadius.circular(10) as OutlinedBorder?),
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xff003399)),
        textStyle: MaterialStateProperty.all(TextStyle(
            fontFamily: GoogleFonts.comfortaa().fontFamily,
            color: const Color(0x0fffffff))));
  }
}
