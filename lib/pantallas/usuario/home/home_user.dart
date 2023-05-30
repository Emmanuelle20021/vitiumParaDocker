import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/usuario/home/home_screen.dart';
import 'package:vitium_app/pantallas/usuario/home/postulaciones_screen.dart';
import 'package:vitium_app/pantallas/usuario/perfil/user_profile.dart';

class HomeUsuario extends StatefulWidget {
  const HomeUsuario({super.key});

  @override
  State<HomeUsuario> createState() => _HomeUsuarioState();
}

final User? user = FirebaseAuth.instance.currentUser;
bool hayCambio = false;

class _HomeUsuarioState extends State<HomeUsuario> {
  var _index = 0;
  var screens = [
    const HomeScreen(),
    const Postulaciones(),
    const UserProfile(),
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
  String _correo = '';

  FichaEmpresa(img, nombre) {
    _img = img;
    _nombre = nombre;
    _correo = "";
  }

//setters
  set(correo) => _correo = correo;

  // getters
  get correo => _correo;
  get img => _img;
  get nombre => _nombre;
}
