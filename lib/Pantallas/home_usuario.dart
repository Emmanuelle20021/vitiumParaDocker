import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const logo = "https://i.postimg.cc/j5Rg5s4b/logo-vitium.png";
const colorResaltar = Color(0xff2279A8);
const colorActivo = Color(0xff3E4F88);
const colorInactivo = Colors.grey;
var numeroPantalla = 0;

class HomeUsuario extends StatefulWidget {
  const HomeUsuario({super.key});

  @override
  State<HomeUsuario> createState() => _HomeUsuarioState();
}

class _HomeUsuarioState extends State<HomeUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: barraDeNavegacion(),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: barraSuperior(),
          ),
          Expanded(
            flex: 1,
            child: barraBusqueda(context),
          ),
          Expanded(
            flex: 1,
            child: barraCategorias(),
          ),
          Expanded(
            flex: 1,
            child: barraRecientes(),
          ),
        ],
      ),
    );
  }
}

Widget barraBusqueda(context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      const Flexible(
        flex: 3,
        fit: FlexFit.tight,
        //width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.blueGrey),
            hintText: "Buscar por puesto, empresa, discapacidad.",
            focusColor: colorResaltar,
            border: OutlineInputBorder(),
          ),
        ),
      ),
      Flexible(
        flex: 1,
        child: FloatingActionButton(
          backgroundColor: const Color(0xff32B0F5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {},
          child: const Icon(Icons.checklist_rtl_outlined),
        ),
      ),
    ],
  );
}

Widget barraSuperior() {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 30),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              maxFontSize: 35,
              minFontSize: 25,
              maxLines: 1,
              "Descubre tu",
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 35,
                  color: Color(0xff383838),
                ),
              ),
            ),
            AutoSizeText(
              maxFontSize: 35,
              minFontSize: 25,
              maxLines: 1,
              "trabajo favorito",
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 35,
                  color: colorResaltar,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: Material.defaultSplashRadius * 1.5,
          child: Container(
            alignment: Alignment.topRight,
            child: Image.network(logo),
          ),
        ),
      ],
    ),
  );
}

Widget barraCategorias() {
  return Container(
    alignment: Alignment.centerLeft,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          "Nuestras empresas",
          minFontSize: 16,
          maxFontSize: 25,
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              style: const ButtonStyle(
                alignment: Alignment.center,
                visualDensity: VisualDensity.comfortable,
              ),
              onPressed: () {},
              child: AutoSizeText(
                wrapWords: true,
                "Categorias",
                minFontSize: 10,
                maxFontSize: 15,
                style: GoogleFonts.roboto(color: Colors.black),
              ),
            ),
            const Icon(
              Icons.arrow_right_alt,
              color: colorResaltar,
            )
          ],
        )
      ],
    ),
  );
}

Widget barraRecientes() {
  return Container(
    alignment: Alignment.centerLeft,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          "Nuestras empresas",
          minFontSize: 16,
          maxFontSize: 25,
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              style: const ButtonStyle(
                alignment: Alignment.center,
                visualDensity: VisualDensity.comfortable,
              ),
              onPressed: () {},
              child: AutoSizeText(
                wrapWords: true,
                "Ver todos",
                minFontSize: 14,
                maxFontSize: 22,
                style: GoogleFonts.roboto(
                    color: colorResaltar,
                    fontWeight: FontWeight.w800,
                    fontSize: 18),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget barraDeNavegacion() {
  return CustomNavigationBar(
    currentIndex: numeroPantalla,
    selectedColor: colorActivo,
    unSelectedColor: colorInactivo,
    scaleFactor: 0.3,
    iconSize: 25,
    items: [
      CustomNavigationBarItem(
        icon: const Icon(
          Icons.home,
        ),
      ),
      CustomNavigationBarItem(
        icon: const Icon(
          Icons.work,
        ),
      ),
      CustomNavigationBarItem(
        icon: const Icon(
          Icons.person,
        ),
      ),
    ],
  );
}
