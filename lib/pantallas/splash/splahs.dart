import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/usuario/login/login_user.dart';

class SplahsScreens extends StatelessWidget {
  const SplahsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return PageView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07,
              vertical: MediaQuery.of(context).size.height * 0.08),
          color: background,
          child: FadeInRight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: AutoSizeText(
                    "Vitium",
                    maxFontSize: 18,
                    style: GoogleFonts.comfortaa(
                      textStyle: TextStyle(
                          color: azulVitium, decoration: TextDecoration.none),
                    ),
                  ),
                ),
                SizedBox.fromSize(
                  size: Size(0, MediaQuery.of(context).size.height * 0.35),
                  child: Stack(
                    children: [
                      Image.asset(briefFeli),
                    ],
                  ),
                ),
                AutoSizeText.rich(
                  textAlign: TextAlign.justify,
                  maxFontSize: 37,
                  maxLines: 3,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Encuentra tu\n",
                        style: tituloNegro,
                      ),
                      TextSpan(
                        text: "trabajo ideal\n",
                        style: tituloResaltado,
                      ),
                      TextSpan(
                        text: "con nosotros",
                        style: tituloNegro,
                      ),
                    ],
                  ),
                ),
                Align(
                  heightFactor: 2,
                  alignment: Alignment.topCenter,
                  child: AutoSizeText(
                    "Explora las multiples opciones que tenemos para ti",
                    textAlign: TextAlign.justify,
                    maxFontSize: 15,
                    maxLines: 2,
                    style: tituloGris,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07,
              vertical: MediaQuery.of(context).size.height * 0.08),
          color: background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: AutoSizeText(
                  "Vitium",
                  maxFontSize: 18,
                  style: GoogleFonts.comfortaa(
                    textStyle: TextStyle(
                        color: azulVitium, decoration: TextDecoration.none),
                  ),
                ),
              ),
              SizedBox.fromSize(
                size: Size(0, MediaQuery.of(context).size.height * 0.35),
                child: Image.asset(briefFeli),
              ),
              AutoSizeText.rich(
                textAlign: TextAlign.justify,
                maxFontSize: 37,
                maxLines: 3,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Nada es\n",
                      style: tituloNegro,
                    ),
                    TextSpan(
                      text: "impedimento\n",
                      style: tituloResaltado,
                    ),
                    TextSpan(
                      text: "aqui",
                      style: tituloNegro,
                    ),
                  ],
                ),
              ),
              Align(
                heightFactor: 2,
                alignment: Alignment.topCenter,
                child: AutoSizeText(
                  "Somos fieles creyentes del potencial de los individuos, unete con nosotros.",
                  textAlign: TextAlign.justify,
                  maxFontSize: 15,
                  maxLines: 2,
                  style: tituloGris,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.07,
              right: MediaQuery.of(context).size.width * 0.07,
              top: MediaQuery.of(context).size.height * 0.08,
              bottom: MediaQuery.of(context).size.height * 0.02),
          color: background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: AutoSizeText(
                  "Vitium",
                  maxFontSize: 18,
                  style: GoogleFonts.comfortaa(
                    textStyle: TextStyle(
                        color: azulVitium, decoration: TextDecoration.none),
                  ),
                ),
              ),
              SizedBox.fromSize(
                size: Size(0, MediaQuery.of(context).size.height * 0.35),
                child: Image.asset(briefFeli),
              ),
              AutoSizeText.rich(
                textAlign: TextAlign.justify,
                maxFontSize: 37,
                maxLines: 3,
                TextSpan(
                  children: [
                    TextSpan(text: "Se un pilar\n", style: tituloNegro),
                    TextSpan(
                      text: "en tu empresa\n",
                      style: tituloResaltado,
                    ),
                    TextSpan(text: "soñada", style: tituloNegro),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: AutoSizeText(
                  "Vuelvete nuestro socio y complementate en tu empresa ideal.",
                  textAlign: TextAlign.justify,
                  maxFontSize: 15,
                  maxLines: 2,
                  style: tituloGris,
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: ButtonAnimated(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ButtonAnimated extends StatefulWidget {
  const ButtonAnimated({super.key});

  @override
  State<ButtonAnimated> createState() => _ButtonAnimatedState();
}

class _ButtonAnimatedState extends State<ButtonAnimated> {
  late AnimationController zoomControl;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      controller: (controller) => zoomControl = controller,
      child: TextButton.icon(
        style: const ButtonStyle(
          splashFactory: NoSplash.splashFactory,
        ),
        label: const Text(""),
        onPressed: () {
          zoomControl
            ..reset()
            ..forward();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginUser(),
            ),
          );
        },
        icon: Icon(
          Icons.check,
          color: Colors.blue,
          size: MediaQuery.of(context).size.height * 0.06,
        ),
      ),
    );
  }
}
