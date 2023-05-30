import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/empresa.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/empresa/home/home_empresa.dart';
import 'package:vitium_app/pantallas/empresa/login/login_empresa.dart';
import 'package:vitium_app/pantallas/empresa/perfil/editEnt_profile.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class EnterpriseProfile extends StatefulWidget {
  static String id = "user_registry";
  const EnterpriseProfile({
    super.key,
  });

  @override
  State<EnterpriseProfile> createState() => _EnterpriseProfileState();
}

List<FichaEmpresa> empresas = List.empty(growable: true);
Empresa usuario = Empresa();
String busqueda = "";
final TextEditingController _nameController = TextEditingController();
final TextEditingController _puestoController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _enterpriseController = TextEditingController();

QueryDocumentSnapshot<Object>? usuarioBD;
var id = user?.uid;

class _EnterpriseProfileState extends State<EnterpriseProfile> {
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
        busqueda = usuarioBD?.get("Empresa afiliada");
      },
    );
  }

  Future<Type> rellenarEmpresas(busqueda) async {
    busqueda = await usuarioBD?.get("Empresa afiliada");
    List<FichaEmpresa> empresa = List.empty(growable: true);
    await db.collectionGroup("Empresa").get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.toList().forEach(
              (element) {
                String nombre = element.get("Nombre");
                if (nombre.contains(busqueda)) {
                  FichaEmpresa fichaEmpresa = FichaEmpresa(
                    element.get("Imagen"),
                    element.get("Nombre"),
                  );
                  fichaEmpresa.set(element.get("Correo"));
                  empresa.add(fichaEmpresa);
                }
              },
            ),
          },
        );
    setState(() {
      empresas = List.empty(growable: true);
      empresas = empresa;
    });
    return Null;
  }

  @override
  void initState() {
    rellenarEmpresas(busqueda);
    super.initState();
    buscarUsuario(id);
    FlutterNativeSplash.remove();
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeEnterprise(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_back_sharp),
                      color: background,
                    ),
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
              padding: const EdgeInsets.only(bottom: 275, left: 20),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditEntProfile(
                            correo: empresas.isEmpty ? "" : empresas[0].correo,
                            empresa: empresas.isEmpty ? "" : empresas[0].nombre,
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
                  height: largo * 0.34,
                ),
                Stack(
                  children: [
                    Form(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: _nameTextField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: _emailTextField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: _enterpriseTextField(),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: _puestoTextField()),
                            Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: _phoneTextField()),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
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
            controller: _nameController,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              alignLabelWithHint: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText: "${usuarioBD?.get('Nombre')}",
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
            hintText: "${empresas.isNotEmpty ? empresas[0].correo : ""}",
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
            hintText: "${empresas.isNotEmpty ? empresas[0].nombre : ""}",
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
          readOnly: true,
          controller: _puestoController,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText: "${usuarioBD?.get("Puesto")}",
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
            hintText: "${usuarioBD?.get("Telefono")}",
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
                  builder: (context) => const LoginEmpresa(),
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
