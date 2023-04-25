import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color background = const Color(0xfffdfdfd);
Color accent = const Color(0xff003399);
Color primary = const Color(0xff254AB0);
Color secondary = const Color(0xffFCA34B);
Color tertiary = const Color(0xff4274FC);
Color icon = const Color(0Xff2274A8);
Color title = const Color(0xff000000);
Color text = const Color(0xff383838);

const Map<int, Color> color = {
  50: Color.fromRGBO(37, 74, 176, .1),
  100: Color.fromRGBO(37, 74, 176, .2),
  200: Color.fromRGBO(37, 74, 176, .3),
  300: Color.fromRGBO(37, 74, 176, .4),
  400: Color.fromRGBO(37, 74, 176, .5),
  500: Color.fromRGBO(37, 74, 176, .6),
  600: Color.fromRGBO(37, 74, 176, .7),
  700: Color.fromRGBO(37, 74, 176, .8),
  800: Color.fromRGBO(37, 74, 176, .9),
  900: Color.fromRGBO(37, 74, 176, 1),
};

MaterialColor customColor = const MaterialColor(0xff254AB0, color);

String briefFeli = "assets/brief/brief-feliz.png";
String briefTriste = "assets/brief/brief-triste.png";
String briefConfundido = "assets/brief/brief-confundido.png";
String briefAsombro = "assets/brief/brief-sorprendido.png";
String logoVitium = "assets/vitium/logo-vitium.png";

var tema = ThemeData();

TextStyle splashTitle = TextStyle(
  letterSpacing: 5,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  fontSize: 40,
  fontWeight: FontWeight.w900,
  color: title,
  decoration: TextDecoration.none,
);

var orangeSplash = TextStyle(
  letterSpacing: 5,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  fontSize: 40,
  fontWeight: FontWeight.w900,
  color: secondary,
  decoration: TextDecoration.none,
);

var blueTitle = TextStyle(
  letterSpacing: 5,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  fontSize: 40,
  fontWeight: FontWeight.w900,
  color: accent,
  decoration: TextDecoration.none,
);

var grayTitle = TextStyle(
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: text,
  decoration: TextDecoration.none,
);

var textStylePopUp = TextStyle(
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: accent,
);

const buttonTextStyle = TextStyle(
  color: Colors.pink,
);

const profile = BottomNavigationBarItem(
  icon: Icon(Icons.person_2_outlined),
  activeIcon: Icon(Icons.person),
  label: 'Perfil',
);

const appliedJobs = BottomNavigationBarItem(
  icon: Icon(Icons.work_outline),
  activeIcon: Icon(Icons.work),
  label: 'Trabajos',
);

const home = BottomNavigationBarItem(
  icon: Icon(Icons.home_outlined),
  activeIcon: Icon(Icons.home_filled),
  label: 'Home',
);

var buttonStyle = ButtonStyle(
  shape:
      MaterialStateProperty.all(BorderRadius.circular(20) as OutlinedBorder?),
  backgroundColor: MaterialStateProperty.all<Color>(accent),
);
