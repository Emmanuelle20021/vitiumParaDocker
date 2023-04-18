import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vitium_app/Funcionalidades/busqueda.dart';
import 'package:vitium_app/Funcionalidades/postulante.dart';
import 'package:vitium_app/pantallas/usuario/home/login/login_page.dart';

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
            _buttonBuscarPuesto(),
            _buttonBuscarEmpresa(),
            _buttonEditarCuenta(),
            _buttonFiltrarSalario(),
            _buttonFiltrarDiscapacidad(),
            _buttonPostular(),
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

  Widget _buttonBuscarPuesto() {
    return ElevatedButton(
      onPressed: () async {
        await Busqueda().buscarPuesto("Jefe");
      },
      child: const Text("Buscar P"),
    );
  }

  Widget _buttonBuscarEmpresa() {
    return ElevatedButton(
      onPressed: () async {
        await Busqueda().buscarEmpresa("Tm89STKTUJZmhrNyqloH");
      },
      child: const Text("Buscar E"),
    );
  }

  Widget _buttonFiltrarSalario() {
    return ElevatedButton(
      onPressed: () async {
        await Busqueda().filtrarSalario(21);
      },
      child: const Text("Filtrar salario"),
    );
  }

  Widget _buttonFiltrarDiscapacidad() {
    return ElevatedButton(
      onPressed: () async {
        await Busqueda().filtrarDiscapacidad("Motriz");
      },
      child: const Text("Filtrar Discapacidad"),
    );
  }

  _buttonEditarCuenta() {
    return ElevatedButton(
        onPressed: () async {
          Postulante usuario = Postulante();
          usuario.editarCuenta();
        },
        child: const Text("Editar"));
  }

  void subirCV() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    final file = result.files.first;
    openFile(file);
  }

  void openFile(PlatformFile file) {
    Postulante usuario = Postulante();
    usuario.subirCV(file.path);
  }

  _buttonPostular() {
    return ElevatedButton(
        onPressed: () async {
          subirCV();
          usuario.postular("j7ST7yDHQi7le3hLr0Vw");
        },
        child: const Text("postular"));
  }
}
