// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../../Funcionalidades/empresa.dart';

class HomeEmpresa extends StatefulWidget {
  const HomeEmpresa({super.key});

  @override
  State<HomeEmpresa> createState() => _HomeEmpresaState();
}

final User? user = FirebaseAuth.instance.currentUser;

class _HomeEmpresaState extends State<HomeEmpresa> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${user?.email}"),
            _buttonLogOut(),
            _buttonEnviarEmail(),
            ElevatedButton(
              onPressed: () {
                checkEmailVerification();
              },
              child: const Text("confirmacion"),
            ),
            _buttonEditarCuenta(),
          ],
        ),
      ),
    );
  }

  Widget _buttonLogOut() {
    return ElevatedButton(
      onPressed: () {
        FirebaseAuth.instance.signOut();
      },
      child: const Text("Cerrar Sesión"),
    );
  }

  Future<void> checkEmailVerification() async {
    await user?.reload(); // Recargar la información del usuario
    if (user != null && user!.emailVerified) {
      print('Tu dirección de correo electrónico ha sido verificada.');
    } else {
      print(
          'Tu dirección de correo electrónico no ha sido verificada todavía.');
    }
  }

  Widget _buttonEnviarEmail() {
    return ElevatedButton(
      onPressed: () async {
        if (user != null) {
          await user?.sendEmailVerification();
        }
      },
      child: const Text("Enviar correo"),
    );
  }

  Widget _buttonEditarCuenta() {
    return ElevatedButton(
        onPressed: () async {
          Empresa usuario = Empresa();
          usuario.editarCuenta();
        },
        child: const Text("Editar"));
  }
}
