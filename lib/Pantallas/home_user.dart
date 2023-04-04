import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              child: Text("confirmacion"),
            )
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
}