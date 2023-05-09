import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/postulante.dart';
import 'package:vitium_app/constantes/constantes.dart';

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
              child: AutoSizeText(
                "Información de usuario",
                maxFontSize: maxFontSizeSubTitle,
                style: blueTitle,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: largo * 0.40,
                ),
                Form(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _nameTextField(),
                        ),
                        const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: BirthdayField()),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _phoneTextField()),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _disabilityField())
                      ],
                    ),
                  ),
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
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            controller: _nameController,
            onChanged: (value) {
              value;
              usuario.nombre;
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
              value;
              usuario.nombre;
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
            value;
            usuario.discapacidad;
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
