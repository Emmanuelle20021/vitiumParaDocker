import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/postulante.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart';
import 'package:vitium_app/pantallas/usuario/registro/registro_usuario.dart';

class UserRegistry extends StatefulWidget {
  static String id = "user_registry";
  const UserRegistry({
    super.key,
  });

  @override
  State<UserRegistry> createState() => _UserRegistryState();
}

Postulante usuario = Postulante();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _birthController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();

class _UserRegistryState extends State<UserRegistry> {
  @override
  void dispose() {
    _nameController.dispose();
    _birthController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

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
      body: SingleChildScrollView(
        child: Center(
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
              Column(
                children: [
                  Container(
                    //color: Colors.purple,
                    height: largo * 0.36,
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
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: BirthdayField(),
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
                              child: _buttonSend(),
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
          height: MediaQuery.of(context).size.height * 0.08,
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
          height: MediaQuery.of(context).size.height * 0.08,
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
        height: MediaQuery.of(context).size.height * 0.08,
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
            usuario.discapacidad = value ?? "";
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

Widget _buttonSend() {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * .85,
        height: MediaQuery.of(context).size.height * .06,
        child: FloatingActionButton.extended(
          heroTag: 'boton',
          onPressed: () {
            try {
              agregar(usuario.nombre, usuario.discapacidad,
                  usuario.numeroDeTelefono, usuario.fechaNacimiento);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeUsuario(),
                ),
              );
            } catch (e) {
              pushBrief(context, "Hubo un errror al agregar tu información");
            }
          },
          label: Text(
            "Registrame",
            style: buttonTextStyle,
          ),
          elevation: 10,
        ),
      );
    },
  );
}

class BirthdayField extends StatefulWidget {
  const BirthdayField({super.key});

  @override
  State<BirthdayField> createState() => _BirthdayFieldState();
}

class _BirthdayFieldState extends State<BirthdayField> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.09,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
//Este stack es necesario?
              Stack(
                children: [
                  TextFormField(
                    readOnly: true,
                    controller: _birthController,
                    onChanged: (value) {
                      usuario.fechaNacimiento = value;
                    },
                    validator: (pickedDate) {
                      if (pickedDate == null || pickedDate.isEmpty) {
                        return "Ingrese su fecha de nacimiento";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      hintText: '14-09-2005',
                      labelText: "Fecha de nacimiento",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        locale: const Locale("es", "ES"),
                        initialDate: DateTime(2004),
                        firstDate: DateTime(1923),
                        lastDate: DateTime(2006),
                      );
                      if (pickedDate != null) {
                        String format =
                            DateFormat("dd-MM-yyyy").format(pickedDate);
                        setState(
                          () {
                            _birthController.text = format.toString();
                            usuario.fechaNacimiento = format.toString();
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

void agregar(nombre, discapacidad, telefono, fecha) {
  nombre ??= usuario.nombre;
  discapacidad ??= usuario.discapacidad;
  telefono ??= usuario.numeroDeTelefono;
  fecha ??= usuario.fechaNacimiento;

  if (nombre == "" || discapacidad == "" || telefono == "" || fecha == "") {
    MaterialPageRoute(
      builder: (context) => pushBrief(context, "Rellena los campos faltantes"),
    );
    return;
  }

  final postulante = <String, String>{
    "Nombre": nombre,
    "Telefono": telefono,
    "Discapacidad": discapacidad,
    "FechaNacimiento": fecha
  };

  db.collection("Perfil").doc(user?.uid).set(postulante).onError(
        (error, stackTrace) => {
          MaterialPageRoute(
            builder: (context) =>
                pushBrief(context, "Ocurrio un error inesperado"),
          )
        },
      );
}
