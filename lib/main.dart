import 'package:flutter/material.dart';
import 'package:vitium_app/Pantallas/IntroScreenCustomConfig.dart';
import 'package:vitium_app/Pantallas/IntroScreenCustomayout.dart';
//import 'package:vitium_app/Componentes/componentes.dart';
//import 'package:vitium_app/Pantallas/bienvenida_1.dart';
import 'Pantallas/IntroScreenDefault.dart';
//import 'package:vitium_app/Pantallas/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroScreenCustomConfig(),
    );
  }
}
