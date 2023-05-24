import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitium_app/Funcionalidades/postulante.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart';
import 'package:vitium_app/pantallas/usuario/login/login_user.dart';
import 'package:vitium_app/pantallas/usuario/perfil/edit_profile.dart';

class UserProfile extends StatefulWidget {
  static String id = "user_registry";
  const UserProfile({
    super.key,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

QueryDocumentSnapshot<Object>? usuarioBD;
FirebaseFirestore db = FirebaseFirestore.instance;

handleSubmit() async {
  if (!_formKey.currentState!.validate()) return;
  await usuario.iniciarSesion();
}

Postulante usuario = Postulante();
final _formKey = GlobalKey<FormState>();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
var id = user!.uid;

class _UserProfileState extends State<UserProfile> {
  buscarUsuario(idUsuario) async {
    hayCambio = false;
    usuarioBD = null;
    QueryDocumentSnapshot<Object>? usuarios;
    await db.collectionGroup("Perfil").get().then(
          (value) => {
            value.docs.toList().forEach((element) {
              if (element.id == idUsuario) {
                usuarios = element;
              }
            })
          },
        );
    setState(() {
      usuarioBD ??= usuarios;
    });
  }

  @override
  void initState() {
    super.initState();
    buscarUsuario(id);
  }

  @override
  Widget build(BuildContext context) {
    hayCambio ? buscarUsuario(id) : () {};
    final ancho = MediaQuery.of(context).size.width;
    final largo = MediaQuery.of(context).size.height;
    final tam = largo * .20;
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              width: ancho,
              height: largo * .3,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: tertiary,
                      borderRadius: const BorderRadiusDirectional.vertical(
                        bottom: Radius.elliptical(100, 20),
                      ),
                    ),
                    height: largo * .20,
                  ),
                  Positioned(
                    left: ancho * 0.30,
                    top: largo * 0.10,
                    child: Container(
                      height: tam,
                      width: tam,
                      decoration: BoxDecoration(
                        color: background,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: accent,
                        ),
                      ),
                      child: Icon(
                        color: primary,
                        Icons.person,
                        size: tam,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 200, left: 10),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  AutoSizeText(
                    "Información de usuario",
                    maxFontSize: maxFontSizeSubTitle,
                    style: TextStyle(
                        fontFamily: GoogleFonts.comfortaa().fontFamily,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: accent),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(
                            fecha: usuarioBD!.get("FechaNacimiento"),
                          ),
                        ),
                      ).whenComplete(() => buscarUsuario(id));
                    },
                    icon: const Icon(Icons.edit),
                    color: primary,
                  )
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: largo * 0.36,
                ),
                Stack(
                  children: [
                    Form(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _nameTextField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _birthdayField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _phoneTextField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _disabilityField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _buttonLogOut(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget _nameTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.08,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: TextFormField(
            readOnly: true,
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            controller: _nameController,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              alignLabelWithHint: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText: usuarioBD == null ? "" : "${usuarioBD!.get("Nombre")}",
              labelText: "Nombre completo",
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _phoneTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.08,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: TextFormField(
            readOnly: true,
            controller: _phoneController,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              alignLabelWithHint: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText:
                  usuarioBD == null ? "" : "${usuarioBD!.get("Telefono")}",
              labelText: "Teléfono",
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _disabilityField() {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.08,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: TextFormField(
          readOnly: true,
          controller: _phoneController,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText:
                usuarioBD == null ? "" : "${usuarioBD!.get("Discapacidad")}",
            labelText: "Discapacidad",
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget _birthdayField() {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.08,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText:
                usuarioBD == null ? "" : "${usuarioBD!.get("FechaNacimiento")}",
            labelText: "Fecha de nacimiento",
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget _buttonLogOut() {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * .85,
        height: MediaQuery.of(context).size.height * .06,
        child: Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                fontFamily: GoogleFonts.comfortaa().fontFamily,
                decoration: TextDecoration.underline,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginUser(),
                ),
              );
              FirebaseAuth.instance.signOut();
            },
            child: const Text(
              'Cerrar Sesión',
              style: TextStyle(
                color: Color.fromARGB(255, 219, 35, 22),
              ),
            ),
          ),
        ),
      );
    },
  );
}
