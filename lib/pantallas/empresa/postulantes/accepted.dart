// ignore_for_file: unused_field
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/empresa.dart';
import 'package:vitium_app/Funcionalidades/reunion.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:vitium_app/pantallas/usuario/registro/registro_usuario.dart';

// ignore: must_be_immutable
class Accepted extends StatefulWidget {
  QueryDocumentSnapshot postulacion;
  QueryDocumentSnapshot postulante;
  static String id = "user_registry";
  Accepted({
    required this.postulacion,
    required this.postulante,
    super.key,
  });

  @override
  State<Accepted> createState() => _AcceptedState();
}

Reunion reunion = Reunion();

final TextEditingController _horaController = TextEditingController();
final TextEditingController _fechaController = TextEditingController();
final TextEditingController _mensajeController = TextEditingController();

class _AcceptedState extends State<Accepted> {
  QueryDocumentSnapshot<Object>? vacante;
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    Size tamano = MediaQuery.of(context).size;
    double alto = tamano.height;
    double ancho = tamano.width;
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: BackButton(
                    color: accent,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        "Detalles de reunión",
                        style: TextStyle(
                            fontSize: ancho * .07, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: alto * .07,
                          child: Image.asset(logoVitium, fit: BoxFit.contain),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: alto * .1,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: tertiary),
                    color: background,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: ancho * 0.07),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.person_add, color: primary, size: ancho * .15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            "${widget.postulante.get("Nombre")}",
                            style: TextStyle(fontSize: ancho * .05),
                          ),
                          AutoSizeText(
                            "${widget.postulante.get("Discapacidad")}",
                            style: TextStyle(fontSize: ancho * .04),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20, right: 260),
                        child: Text(
                          "Horario:",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Stack(
                        children: [
                          Form(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: DateField(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _mensajeTextField(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: _buttonSend(widget.postulacion),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget _mensajeTextField() {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _mensajeController,
            onChanged: (value) {
              reunion.mensaje = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingrese un mensaje";
              }
              return null;
            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              alignLabelWithHint: false,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              hintText:
                  "Es de nuestro agrado informarle que \nha sido seleccionado para una\nentrevista. \nLugar: Vitium sucursal centro",
              labelText: "Mensaje",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget _buttonSend(postulacion) {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * .80,
        height: MediaQuery.of(context).size.height * .06,
        child: FloatingActionButton.extended(
          heroTag: 'boton',
          onPressed: () {
            aceptar(
              "${reunion.fecha} ${reunion.horario}\n${reunion.mensaje}",
              postulacion,
            );
            Navigator.pop(context);
          },
          label: Text(
            "Enviar",
            style: buttonTextStyle,
          ),
          elevation: 10,
        ),
      );
    },
  );
}

class DateField extends StatefulWidget {
  const DateField({super.key});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  TimeOfDay time = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.09,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.height * 0.19,
                    child: TextFormField(
                      readOnly: true,
                      controller: _fechaController,
                      onChanged: (value) {
                        reunion.fecha = value;
                      },
                      validator: (pickedDate) {
                        if (pickedDate == null || pickedDate.isEmpty) {
                          return "Ingrese una fecha para la reunión";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.today),
                        alignLabelWithHint: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        hintText: '24-09-2023',
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
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2024),
                        );
                        if (pickedDate != null) {
                          String format =
                              DateFormat("dd-MM-yyyy").format(pickedDate);
                          setState(
                            () {
                              _fechaController.text = format.toString();
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height * 0.19,
                      child: TextFormField(
                        readOnly: true,
                        controller: _horaController,
                        onChanged: (value) {
                          reunion.fecha = value;
                        },
                        validator: (pickedDate) {
                          if (pickedDate == null || pickedDate.isEmpty) {
                            return "Ingrese una hora para la reunión";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.more_time),
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          hintText: '$hour:$minute',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: time,
                          );

                          if (pickedTime != null) {
                            setState(() {
                              time = pickedTime;
                            });
                          }
                        },
                      ),
                    ),
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

void aceptar(mensaje, QueryDocumentSnapshot postulacion) {
  mensaje ??= "";
  if (mensaje == "") {
    MaterialPageRoute(
      builder: (context) => pushBrief(context, "Rellena los campos faltantes"),
    );
    return;
  }

  final postulante = <String, String>{
    "Curriculum": postulacion.get("Curriculum"),
    "Estado": "Aceptado",
    "Mensaje": mensaje,
    "Postulante": postulacion.get("Postulante"),
    "Vacante": postulacion.get("Vacante")
  };

  db
      .collection("Postulaciones")
      .doc(postulacion.id)
      .set(postulante)
      .onError((error, stackTrace) => {});
}
