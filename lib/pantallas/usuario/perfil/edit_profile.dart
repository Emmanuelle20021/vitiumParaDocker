import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/postulante.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/usuario/perfil/user_profile.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart';

class EditProfile extends StatefulWidget {
  static String id = "user_registry";
  final String fecha;
  const EditProfile({
    required this.fecha,
    super.key,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

handleSubmit() async {
  if (!_formKey.currentState!.validate()) return;
  await usuario.iniciarSesion();
}

Postulante usuario = Postulante();
final _formKey = GlobalKey<FormState>();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();

class _EditProfileState extends State<EditProfile> {
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
                              child: _phoneTextField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _disabilityField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: _buttonSave(widget.fecha),
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
              usuario.nombre = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingrese su nombre";
              }
              return null;
            },
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
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
              alignLabelWithHint: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText: "9211450967",
              labelText: "Teléfono",
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

Widget _disabilityField() {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.10,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: DropdownButtonFormField(
          items: <String>["Auditiva", "Física", "Habla", "Motriz", "Múltiple"]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            );
          }).toList(),
          //controller: _nameController,
          onChanged: (value) {
            usuario.discapacidad = value!;
          },
          validator: (value) {
            if (value == null) {
              return "Seleccione una discapacidad";
            }
            return null;
          },
          //keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText: "Motriz",
            labelText: "Discapacidad",
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

Widget _buttonSave(fecha) {
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
              usuario.nombre,
              usuario.discapacidad,
              usuario.numeroDeTelefono,
              fecha,
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

void editar(nombre, discapacidad, telefono, fecha) {
  final postulante = <String, String>{
    "Nombre": nombre,
    "Telefono": telefono,
    "Discapacidad": discapacidad,
    "FechaNacimiento": fecha
  };

  db
      .collection("Perfil")
      .doc(user?.uid)
      .set(postulante)
      .onError((error, stackTrace) => {});
}
