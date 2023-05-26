import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/constantes/tema.dart';
import 'package:vitium_app/pantallas/empresa/perfil/editEnt_profile.dart';
import 'package:vitium_app/pantallas/empresa/perfil/ent_profile.dart';

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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'),
      ],
      debugShowCheckedModeBanner: false,
      home: const EnterpriseProfile(),
    );
  }
}
