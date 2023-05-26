// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/empresa.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart';
import 'package:auto_size_text/auto_size_text.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class EditEntProfile extends StatefulWidget {
  static String id = "user_registry";
  const EditEntProfile({
    super.key,
  });

  @override
  State<EditEntProfile> createState() => _EditEntProfileState();
}

handleSubmit() async {
  if (!_formKey.currentState!.validate()) return;
  await usuario.iniciarSesion();
}

Empresa usuario = Empresa();
final _formKey = GlobalKey<FormState>();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _puestoController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _enterpriseController = TextEditingController();

class _EditEntProfileState extends State<EditEntProfile> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final largo = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              SizedBox(
                width: ancho,
                height: 90,
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
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    //color: Colors.purple,
                    height: largo * .19,
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.bottomLeft,
                    child: AutoSizeText(
                      "Información de usuario",
                      maxFontSize: maxFontSizeSubTitle,
                      style: TextStyle(
                          fontFamily: GoogleFonts.comfortaa().fontFamily,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: accent),
                    ),
                  ),
                  Stack(
                    children: [
                      Form(
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
                              child: _buttonSave(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _nameTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.10,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: TextFormField(
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            controller: _nameController,
            onChanged: (value) {
              usuario.nombreEmpleado = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingrese su nombre";
              }
              return null;
            },
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              alignLabelWithHint: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText: "Brief Case",
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
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: _puestoController,
          onChanged: (value) {
            usuario.puesto = value;
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Ingrese el puesto";
            }
            return null;
          },
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText: "Gerente de RR.HH",
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
        height: MediaQuery.of(context).size.height * 0.10,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: TextFormField(
          controller: _phoneController,
          onChanged: (value) {
            usuario.numeroDeTelefono = value;
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Ingrese su número telefónico";
            }
            return null;
          },
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText: "9212972943",
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

Widget _buttonSave() {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * .85,
        height: MediaQuery.of(context).size.height * .06,
        child: FloatingActionButton.extended(
          heroTag: 'boton',
          onPressed: () {
            hayCambio = true;
            editar(
              usuario.nombreEmpleado,
              usuario.puesto,
              usuario.numeroDeTelefono,
            );
            Navigator.pop(context);
          },
          label: Text(
            "Guardar",
            style: buttonTextStyle,
          ),
          elevation: 10,
        ),
      );
    },
  );
}

void editar(nombre, puesto, telefono) {
  final reclutador = <String, String>{
    "Nombre": nombre,
    "Telefono": telefono,
    "Puesto": puesto,
  };

  db
      .collection("Reclutador")
      .doc(user?.uid)
      .set(reclutador)
      .onError((error, stackTrace) => {});
}
