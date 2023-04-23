import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color background = const Color(0xfffdfdfd);
Color azulVitium = const Color(0xff003399);
Color azulSecundario = const Color(0xff254AB0);
Color resaltado = const Color(0xff4274FC);
Color gris = const Color(0xff383838);
Color naranja = const Color(0xffFCA34B);
Color negro = const Color(0xff000000);

String briefFeli = "https://i.postimg.cc/W1F9SrwV/thumbnail-MALETIN-RANA-1.png";
String briefTriste =
    "https://i.postimg.cc/JzfpFnpk/thumbnail-MALETIN-RANA-TROSTEpng.png";
String briefConfundido =
    "https://i.postimg.cc/m26XQVMV/thumbnail-MALETIN-RANA.png";
String briefAsombro =
    "https://i.postimg.cc/zXf2b4LV/thumbnail-MALETIN-RANA-plain.png";
String logoVitium = "assets/vitium/logo-vitium.png";

var tema = ThemeData(
  iconButtonTheme: IconButtonThemeData(style: buttonStyle),
);

TextStyle splashNegro = TextStyle(
  letterSpacing: 5,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  fontSize: 40,
  fontWeight: FontWeight.bold,
  color: negro,
  decoration: TextDecoration.none,
);

var splashNaranja = TextStyle(
  letterSpacing: 5,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  fontSize: 40,
  fontWeight: FontWeight.bold,
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
