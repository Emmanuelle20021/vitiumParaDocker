// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/empresa.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/empresa/perfil/ent_profile.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart';
import 'package:auto_size_text/auto_size_text.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// ignore: must_be_immutable
class EditEntProfile extends StatefulWidget {
  static String id = "user_registry";
  String empresa;
  String correo;
  EditEntProfile({
    required this.correo,
    required this.empresa,
    super.key,
  });

  @override
  State<EditEntProfile> createState() => _EditEntProfileState();
}

Empresa usuario = Empresa();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _puestoController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _enterpriseController = TextEditingController();
var id = user?.uid;
QueryDocumentSnapshot<Object>? usuarioBD;

class _EditEntProfileState extends State<EditEntProfile> {
  @override
  void initState() {
    super.initState();
    buscarUsuario(id);
    FlutterNativeSplash.remove();
  }

  buscarUsuario(idUsuario) async {
    hayCambio = false;
    usuarioBD = null;
    QueryDocumentSnapshot<Object>? usuarios;
    await db.collectionGroup("Reclutador").get().then(
          (value) => {
            value.docs.toList().forEach((element) {
              if (element.id == idUsuario) {
                usuarios = element;
              }
            })
          },
        );
    setState(
      () {
        usuarioBD ??= usuarios;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    usuario.empresaAfiliada = widget.empresa;
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnterpriseProfile(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_back_sharp),
                  color: background,
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
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              alignLabelWithHint: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText: "${usuarioBD!.get("Nombre")}",
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
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              alignLabelWithHint: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText: widget.correo,
              labelText: "Correo Electrónico",
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
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText: "${usuarioBD!.get("Empresa afiliada")}",
            labelText: "Empresa afiliada",
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
          decoration: InputDecoration(
            alignLabelWithHint: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText: "${usuarioBD!.get("Puesto")}",
            labelText: "Puesto",
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
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText: "${usuarioBD!.get("Telefono")}",
            labelText: "Teléfono empresarial",
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

Widget _buttonSave() {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * .85,
        height: MediaQuery.of(context).size.height * .06,
        child: FloatingActionButton.extended(
          heroTag: 'boton',
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (context) => AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                titlePadding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .15, top: 20),
                title: Text(
                  "¿Guardar cambios?",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * .03),
                ),
                alignment: Alignment.bottomCenter,
                elevation: 0,
                insetPadding: const EdgeInsets.all(0),
                content: SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(briefConfundido),
                ),
                actions: [
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width * .9,
                            MediaQuery.of(context).size.height * .05,
                          ),
                        ),
                        onPressed: () {
                          hayCambio = true;
                          editar(
                            usuario.nombreEmpleado,
                            usuario.puesto,
                            usuario.numeroDeTelefono,
                            usuario.empresaAfiliada,
                          );
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Aceptar",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * .05,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width * .9,
                            MediaQuery.of(context).size.height * .05,
                          ),
                          backgroundColor: tertiary,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * .05,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ).then(
              (value) => Navigator.pop(context),
            );
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

void editar(nombre, puesto, telefono, empresa) {
  nombre ??= usuario.nombreEmpleado;
  puesto ??= usuario.puesto;
  telefono ??= usuario.numeroDeTelefono;
  empresa ??= usuario.empresaAfiliada;

  final reclutador = <String, String>{
    "Nombre": nombre,
    "Empresa afiliada": empresa,
    "Telefono": telefono,
    "Puesto": puesto,
  };

  db
      .collection("Reclutador")
      .doc(user?.uid)
      .set(reclutador)
      .onError((error, stackTrace) => {});
}
