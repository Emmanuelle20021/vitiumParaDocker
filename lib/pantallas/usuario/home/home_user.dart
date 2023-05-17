import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/usuario/home/home_screen.dart';
import 'package:vitium_app/pantallas/usuario/home/perfil_screen.dart';
import 'package:vitium_app/pantallas/usuario/home/trabajos_screen.dart';

class HomeUsuario extends StatefulWidget {
  const HomeUsuario({super.key});

  @override
  State<HomeUsuario> createState() => _HomeUsuarioState();
}

final User? user = FirebaseAuth.instance.currentUser;

class _HomeUsuarioState extends State<HomeUsuario> {
  var _index = 0;
  var screens = [
    const HomeScreen(),
    TrabajosScreen(""),
    const PerfilScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: GNav(
          onTabChange: (value) {
            setState(() {
              _index = value;
            });
          },
            padding: const EdgeInsets.all(20),
          activeColor: accent,
          tabs: const [
            GButton(
              text: 'Inicio',
              icon: Icons.home_filled,
            ),
            GButton(
              text: 'Trabajos',
              icon: Icons.work,
            ),
            GButton(
              text: 'Perfil',
              icon: Icons.person,
            ),
          ],
          color: tertiary,
          gap: 8,
        ),
      ),
      body: screens[_index],
    );
  }
}

class FichaEmpresa {
  String _img = '';
  String _nombre = '';

  FichaEmpresa(img, nombre) {
    _img = img;
    _nombre = nombre;
  }

  // getters
  get img => _img;
  get nombre => _nombre;
}
