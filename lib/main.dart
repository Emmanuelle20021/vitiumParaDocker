import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/constantes/tema.dart';
import 'package:vitium_app/pantallas/empresa/home/home_empresa.dart';
import 'package:vitium_app/pantallas/empresa/login/login_empresa.dart';
import 'package:vitium_app/pantallas/empresa/registro/registro_empresa.dart';
import 'package:vitium_app/pantallas/error/sin_conexion.dart';
import 'package:vitium_app/pantallas/splash/splahs.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart';
import 'package:vitium_app/pantallas/usuario/login/login_user.dart';
import 'package:vitium_app/pantallas/usuario/registro/registro_usuario.dart';

var _rutas = {
  "/": (context) => const SplahsScreens(),
  "/loginUser": (context) => const LoginUser(),
  "/loginEmpresa": (context) => const LoginEmpresa(),
  "/registroUser": (context) => const RegistroUsuario(),
  "/registroEmpresa": (context) => const RegistroEmpresa(),
  "/homeUser": (context) => const HomeUsuario(),
  "/homeEmpresa": (context) => const HomeEmpresa(),
  "/sinConexion": (context) => const SinConexion(),
};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  runApp(
    const VitiumApp(),
  );
}

class VitiumApp extends StatelessWidget {
  const VitiumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: tema,
      debugShowCheckedModeBanner: false,
      routes: _rutas,
      initialRoute: "/",
    );
  }
}
