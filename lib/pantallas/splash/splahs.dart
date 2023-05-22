import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart';
import 'package:vitium_app/pantallas/usuario/login/login_user.dart';

User? usuario = FirebaseAuth.instance.currentUser;

class SplahsScreens extends StatelessWidget {
  const SplahsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      body: PageView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: const [
          PaginaSplash1(),
          PaginaSplash2(),
          PaginaSplash3(),
        ],
      ),
    );
  }
}

class PaginaSplash3 extends StatelessWidget {
  const PaginaSplash3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.07,
          right: MediaQuery.of(context).size.width * 0.07,
          top: MediaQuery.of(context).size.height * 0.08,
          bottom: MediaQuery.of(context).size.height * 0.02),
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
                  textStyle:
                      TextStyle(color: icon, decoration: TextDecoration.none),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size(0, MediaQuery.of(context).size.height * 0.35),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(mancha),
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
                  TextSpan(text: "Se un pilar\n", style: splashTitle),
                  TextSpan(
                    text: "en tu empresa\n",
                    style: orangeSplash,
                  ),
                  TextSpan(text: "soñada", style: splashTitle),
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
                style: grayTitle,
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: ButtonAnimated(),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginaSplash2 extends StatelessWidget {
  const PaginaSplash2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  textStyle:
                      TextStyle(color: icon, decoration: TextDecoration.none),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size(0, MediaQuery.of(context).size.height * 0.35),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(mancha),
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
                    text: "Nada es\n",
                    style: splashTitle,
                  ),
                  TextSpan(
                    text: "impedimento\n",
                    style: orangeSplash,
                  ),
                  TextSpan(
                    text: "aqui",
                    style: splashTitle,
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
                style: grayTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginaSplash1 extends StatelessWidget {
  const PaginaSplash1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  textStyle:
                      TextStyle(color: icon, decoration: TextDecoration.none),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size(0, MediaQuery.of(context).size.height * 0.35),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(mancha),
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
                    style: splashTitle,
                  ),
                  TextSpan(
                    text: "trabajo ideal\n",
                    style: orangeSplash,
                  ),
                  TextSpan(
                    text: "con nosotros",
                    style: splashTitle,
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
                style: grayTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonAnimated extends StatefulWidget {
  const ButtonAnimated({super.key});

  @override
  State<ButtonAnimated> createState() => _ButtonAnimatedState();
}

class _ButtonAnimatedState extends State<ButtonAnimated> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: TextButton.icon(
        style: const ButtonStyle(
          splashFactory: NoSplash.splashFactory,
        ),
        label: const Text(""),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                if (usuario == null) {
                  return const LoginUser();
                } else {
                  return const HomeUsuario();
                }
              },
            ),
          );
        },
        icon: Hero(
          tag: "Unique",
          child: Icon(
            Icons.check,
            color: accent,
            size: MediaQuery.of(context).size.height * 0.06,
          ),
        ),
      ),
    );
  }
}


