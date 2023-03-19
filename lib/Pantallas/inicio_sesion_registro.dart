import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InicioSesionRegistro extends StatefulWidget {
  const InicioSesionRegistro({super.key});

  @override
  State<InicioSesionRegistro> createState() => _InicioSesionRegistroState();
}

const imagen = "https://i.postimg.cc/G2wFhrGj/log-In-usuario.png";
const bannerGradient = LinearGradient(
    begin: Alignment.topCenter, colors: [Color(0xff01b3f1), Color(0xff00d4df)]);
const tituloStyle = TextStyle(fontSize: 40, fontWeight: FontWeight.w900);
const textoCentral =
    "Somos una organización socialmente responsable comprometidos con la comunidad de personas con discapacidad";
const textoCentralStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

class _InicioSesionRegistroState extends State<InicioSesionRegistro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          bannerTop(context),
          Expanded(flex: 1, child: titulo()),
          Expanded(flex: 1, child: texto()),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                boton(
                  "Iniciar Sesión",
                  const Color(0xff2A97D1),
                ),
                boton(
                  "Registrarse",
                  const Color(0xff154B69),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: TextButton(
              onPressed: () {},
              child: const AutoSizeText(
                "¿Eres reclutador?",
                maxFontSize: 18,
                minFontSize: 10,
                style: TextStyle(color: Colors.red),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget bannerTop(var context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.5,
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.only(bottom: 5),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            offset: const Offset(0, 5),
            blurRadius: 4,
            spreadRadius: 1)
      ],
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
      gradient: bannerGradient,
    ),
    child: Image.network(imagen),
  );
}

Widget titulo() {
  return Container(
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.only(left: 5),
    child: AutoSizeText(
      "Ofreciendo Oportunidades",
      minFontSize: 20,
      maxLines: 2,
      textDirection: TextDirection.ltr,
      style: GoogleFonts.dmSans(textStyle: tituloStyle),
    ),
  );
}

Widget texto() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(left: 12, right: 30),
    child: AutoSizeText(
      textoCentral,
      maxFontSize: 20,
      minFontSize: 10,
      style: GoogleFonts.dmSans(textStyle: textoCentralStyle),
      textAlign: TextAlign.left,
    ),
  );
}

Widget boton(String nombre, Color color) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: color,
      mouseCursor: MaterialStateMouseCursor.clickable,
      label: AutoSizeText(nombre, minFontSize: 10, maxFontSize: 16),
      shape: const BeveledRectangleBorder(side: BorderSide.none),
    ),
  );
}
