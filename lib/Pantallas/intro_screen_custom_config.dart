import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitium_app/Pantallas/inicio_sesion_registro.dart';

class IntroScreenCustomConfig extends StatefulWidget {
  const IntroScreenCustomConfig({Key? key}) : super(key: key);

  @override
  IntroScreenCustomConfigState createState() => IntroScreenCustomConfigState();
}

// ------------------ Custom config ------------------
class IntroScreenCustomConfigState extends State<IntroScreenCustomConfig> {
  List<ContentConfig> listContentConfig = [];
  Color activeColor = const Color.fromARGB(255, 23, 159, 166);
  Color inactiveColor = const Color(0Xff154B69);
  Color backgroundColor = const Color(0xffFFFFFF);
  double sizeIndicator = 20;

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      ContentConfig(
        title: "VITIUM",
        textAlignTitle: TextAlign.right,
        styleTitle: GoogleFonts.dmSans(
          color: const Color(0Xff154B69),
          fontSize: 18,
        ),
        description: "Explora en las multiples opciones que tenemos para ti.",
        textAlignDescription: TextAlign.left,
        styleDescription: GoogleFonts.dmSans(
          color: Colors.black,
          fontSize: 20.0,
        ),
        centerWidget: Container(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Image.asset("assets/splash_1.png"),
                Container(
                  padding: const EdgeInsets.all(0),
                  alignment: const FractionalOffset(0.1, 0.1),
                  child: Text(
                    "Encuentra tu",
                    style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  alignment: const FractionalOffset(0.1, 0.1),
                  child: Text(
                    "trabajo ideal",
                    style: GoogleFonts.dmSans(
                      color: Colors.amber,
                      decoration: TextDecoration.underline,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  alignment: const FractionalOffset(0.1, 0.1),
                  child: Text(
                    "con nosotros",
                    style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            )),
        onCenterItemPress: () {},
        backgroundColor: backgroundColor,
      ),
    );
    listContentConfig.add(
      ContentConfig(
        title: "VITIUM",
        textAlignTitle: TextAlign.right,
        styleTitle: GoogleFonts.dmSans(
          color: const Color(0Xff154B69),
          fontSize: 18,
        ),
        description:
            "Somos fieles creyentes del potencial de los individuos, unete con nosotros.",
        textAlignDescription: TextAlign.left,
        styleDescription: GoogleFonts.dmSans(
          color: Colors.black,
          fontSize: 20.0,
        ),
        centerWidget: Container(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Image.asset("assets/splash_2.png"),
                Container(
                  padding: const EdgeInsets.all(0),
                  alignment: const FractionalOffset(0.05, 0.05),
                  child: Text(
                    "Nada es",
                    style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  alignment: const FractionalOffset(0.1, 0.1),
                  child: Text("impedimento",
                      style: GoogleFonts.dmSans(
                        color: Colors.amber,
                        decoration: TextDecoration.underline,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  alignment: const FractionalOffset(0.04, 0.04),
                  child: Text(
                    "aquí",
                    style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            )),
        backgroundColor: backgroundColor,
        maxLineTextDescription: 3,
      ),
    );
    listContentConfig.add(
      ContentConfig(
        title: "VITIUM",
        textAlignTitle: TextAlign.right,
        styleTitle: GoogleFonts.dmSans(
          color: const Color(0Xff154B69),
          fontSize: 18,
        ),
        description:
            "Vuelvete nuestro socio y complementate en tu empresa ideal.",
        textAlignDescription: TextAlign.left,
        styleDescription: GoogleFonts.dmSans(
          color: Colors.black,
          fontSize: 20.0,
        ),
        centerWidget: Container(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Image.asset("assets/splash_3.png"),
                Container(
                  padding: const EdgeInsets.all(0),
                  alignment: const FractionalOffset(0.05, 0.05),
                  child: Text(
                    "Se un pilar",
                    style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  alignment: const FractionalOffset(0.1, 0.1),
                  child: Text(
                    "en tu empresa",
                    style: GoogleFonts.dmSans(
                      color: Colors.amber,
                      decoration: TextDecoration.underline,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  alignment: const FractionalOffset(0.05, 0.05),
                  child: Text(
                    "soñada",
                    style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            )),
        backgroundColor: backgroundColor,
        maxLineTextDescription: 3,
      ),
    );
  }

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InicioSesionRegistro(),
      ),
    );
  }

  void onNextPress() {
    log("onNextPress caught");
  }

  Widget renderNextBtn() {
    return const Icon(
      Icons.arrow_forward_rounded,
      size: 25,
    );
  }

  Widget renderDoneBtn() {
    return const Icon(
      Icons.done,
      size: 25,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<CircleBorder>(
        const CircleBorder(
          side: BorderSide(color: Colors.transparent),
        ),
      ),
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0Xff154B69)),
      foregroundColor: MaterialStateProperty.all<Color>(backgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      // Content config
      listContentConfig: listContentConfig,
      backgroundColorAllTabs: Colors.grey,
      //Skip
      isShowSkipBtn: false,

      //Prev
      isShowPrevBtn: false,

      // Next button
      renderNextBtn: renderNextBtn(),
      onNextPress: onNextPress,
      // ignore: prefer_const_constructors
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: renderDoneBtn(),
      onDonePress: onDonePress,
      doneButtonStyle: myButtonStyle(),

      // Indicator
      indicatorConfig: IndicatorConfig(
        sizeIndicator: sizeIndicator,
        indicatorWidget: Container(
          width: sizeIndicator,
          height: 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: inactiveColor),
        ),
        activeIndicatorWidget: Container(
          width: sizeIndicator,
          height: 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: activeColor),
        ),
        spaceBetweenIndicator: 10,
        typeIndicatorAnimation: TypeIndicatorAnimation.sliding,
      ),

      // Navigation bar
      navigationBarConfig: NavigationBarConfig(
        navPosition: NavPosition.bottom,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top > 0 ? 20 : 10,
          bottom: MediaQuery.of(context).viewPadding.bottom > 0 ? 20 : 10,
        ),
      ),

      // Scroll behavior
      curveScroll: Curves.bounceIn,
    );
  }
}
