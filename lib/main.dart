// ignore_for_file: unused_import

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Componentes/calendario.dart';
import 'package:vitium_app/constantes/navigation.dart';
import 'package:vitium_app/constantes/tema.dart';
import 'package:vitium_app/pantallas/splash/splahs.dart';
import 'package:vitium_app/pantallas/usuario/login/login_user.dart';
import 'package:vitium_app/pantallas/usuario/perfil/user_profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'),
      ],
      debugShowCheckedModeBanner: false,
      home: const UserProfile(),
    );
  }
}
