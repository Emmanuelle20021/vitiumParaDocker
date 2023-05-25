import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/postulante.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/usuario/login/login_user.dart';
import 'package:vitium_app/pantallas/empresa/perfil/editEnt_profile.dart';

class EnterpriseProfile extends StatefulWidget {
  const EnterpriseProfile({
    super.key,
  });

  @override
  State<EnterpriseProfile> createState() => _EnterpriseProfileState();
}

handleSubmit() async {
  if (!_formKey.currentState!.validate()) return;
  await usuario.iniciarSesion();
}

Postulante usuario = Postulante();
final _formKey = GlobalKey<FormState>();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _puestoController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _enterpriseController = TextEditingController();

class _EnterpriseProfileState extends State<EnterpriseProfile> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
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
                    "Perfil de empresa",
                    maxFontSize: maxFontSizeSubTitle,
                    style: TextStyle(
                        fontFamily: GoogleFonts.comfortaa().fontFamily,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: accent),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditEntProfile(),
                        ),
                      );
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
                              child: _emailTextField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _enterpriseTextField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _puestoTextField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _phoneTextField(),
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
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              alignLabelWithHint: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText: "Bief Case",
              labelText: "Nombre completo",
              border: OutlineInputBorder(
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

  Widget _emailTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.08,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: TextFormField(
            readOnly: true,
            controller: _emailController,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              alignLabelWithHint: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText: "email@empresa.com.mx",
              labelText: "Correo Electrónico",
              border: OutlineInputBorder(
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

Widget _enterpriseTextField() {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.08,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: TextFormField(
          readOnly: true,
          controller: _enterpriseController,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText: "Vitium",
            labelText: "Empresa afiliada",
            border: OutlineInputBorder(
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

Widget _puestoTextField() {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.08,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: TextFormField(
          readOnly: true,
          controller: _puestoController,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText: "Gerente de ventas",
            labelText: "Puesto",
            border: OutlineInputBorder(
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
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText: "9212027573",
            labelText: "Teléfono empresarial",
            border: OutlineInputBorder(
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
