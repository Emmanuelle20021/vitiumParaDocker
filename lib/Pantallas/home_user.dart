import 'dart:io';

import 'package:file_picker/src/platform_file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vitium_app/Funcionalidades/busqueda.dart';
// ignore: implementation_imports
import 'package:file_picker/src/file_picker.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

final User? user = FirebaseAuth.instance.currentUser;

class _HomeUserState extends State<HomeUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
            _buttonBuscarVacantes(),
            _buttonSubirCV(),
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

  Widget _buttonBuscarVacantes() {
    return ElevatedButton(
      onPressed: () async {
        await Busqueda().buscar();
      },
      child: const Text("Buscar"),
    );
  }

  Widget _buttonSubirCV() {
    return ElevatedButton(
      onPressed: () async {
        final result = await FilePicker.platform.pickFiles();
        if (result == null) return;

        final file = result.files.first;
        openFile(file);
      },
      child: const Text("Subir CV"),
    );
  }

  void openFile(PlatformFile file) {
    print(file.path);
  }
}
