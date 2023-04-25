import 'package:device_preview/device_preview.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/pantallas/splash/splahs.dart';
import 'package:vitium_app/constantes/tema.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const VitiumApp(),
    ),
  );
}

class VitiumApp extends StatelessWidget {
  const VitiumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: tema,
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        home:
            const SplahsScreens() /*StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeUser();
          } else {
            return const LoginPage();
          }
        },
      ),
    */
        );
  }
}
