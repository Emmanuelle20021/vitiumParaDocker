import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color background = const Color(0xfffdfdfd);
Color azulVitium = const Color(0xff003399);
Color azulSecundario = const Color(0xff254AB0);
Color resaltado = const Color(0xff4274FC);
Color gris = const Color(0xff383838);
Color naranja = const Color(0xffFCA34B);
Color negro = const Color(0xff000000);

String briefFeli = "assets/brief/brief-feliz.png";
String briefTriste = "assets/brief/brief-triste.png";
String briefConfundido = "assets/brief/brief-confundido.png";
String briefAsombro = "assets/brief/brief-sorprendido.png";
String logoVitium = "assets/vitium/logo-vitium.png";

var tema = ThemeData();

TextStyle tituloNegro = TextStyle(
  letterSpacing: 5,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  fontSize: 40,
  fontWeight: FontWeight.w900,
  color: negro,
  decoration: TextDecoration.none,
);

var tituloResaltado = TextStyle(
  letterSpacing: 5,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  fontSize: 40,
  fontWeight: FontWeight.w900,
  color: naranja,
  decoration: TextDecoration.none,
);

var tituloGris = TextStyle(
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: gris,
  decoration: TextDecoration.none,
);

var tituloAzul = TextStyle(
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: azulSecundario,
);

var textStylePopUp = TextStyle(
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: azulVitium,
);

var buttonStyle = ButtonStyle(
  shape:
      MaterialStateProperty.all(BorderRadius.circular(10) as OutlinedBorder?),
  backgroundColor: MaterialStateProperty.all<Color>(azulVitium),
  textStyle: MaterialStateProperty.all(
    TextStyle(
      fontFamily: GoogleFonts.comfortaa().fontFamily,
      color: const Color(0x0fffffff),
    ),
  ),
);
