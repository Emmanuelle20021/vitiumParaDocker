import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/constantes/constantes.dart';

class SinConexion extends StatelessWidget {
  const SinConexion({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: background,
          child: Column(children: const []),
        ),
      ),
    );
  }
}
