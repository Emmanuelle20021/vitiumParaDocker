import 'package:flutter/material.dart';
import 'package:vitium_app/Pantallas/intro_screen_custom_config.dart';

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
