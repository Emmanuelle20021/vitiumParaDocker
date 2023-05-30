// ignore_for_file: unused_field
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/reunion.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Accepted extends StatefulWidget {
  static String id = "user_registry";
  const Accepted({
    super.key,
  });

  @override
  State<Accepted> createState() => _AcceptedState();
}

Reunion reunion = Reunion();

final TextEditingController _horaController = TextEditingController();
final TextEditingController _fechaController = TextEditingController();

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
                            "${vacante?.get("Nombre")}",
                            style: TextStyle(fontSize: ancho * .05),
                          ),
                          AutoSizeText(
                            "${vacante?.get("Puesto")}",
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
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: DateField(),
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

class DateField extends StatefulWidget {
  const DateField({super.key});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  TimeOfDay time = TimeOfDay.now();
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
                    padding: const EdgeInsets.all(11.5),
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
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.more_time),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          hintText: '10:30',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            TimeOfDayFormat format =
                                TimeOfDayFormat.h_colon_mm_space_a;
                            setState(
                              () {
                                time = pickedTime;
                                _horaController.text = format.toString();
                              },
                            );
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
