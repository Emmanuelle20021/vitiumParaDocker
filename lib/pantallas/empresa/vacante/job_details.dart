// ignore_for_file: unused_import

import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/vacante.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/empresa/postulantes/ver_postulantes.dart';
import 'package:vitium_app/pantallas/splash/splahs.dart';

// ignore: must_be_immutable
class JobDetails extends StatefulWidget {
  String vacanteId;
  JobDetails({required this.vacanteId, super.key});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  QueryDocumentSnapshot<Object>? vacante;
  FirebaseFirestore db = FirebaseFirestore.instance;
  late IconData icono;

  buscarVacante(idVacante) async {
    icono = iconos[Random().nextInt(6 - 0)];
    vacante = null;
    QueryDocumentSnapshot<Object>? vacantes;
    await db.collectionGroup("Vacantes").get().then(
          (value) => {
            value.docs.toList().forEach((element) {
              if (element.id == idVacante) {
                vacantes = element;
              }
            })
          },
        );
    setState(() {
      vacante ??= vacantes;
    });
  }

  @override
  initState() {
    buscarVacante(widget.vacanteId);
    super.initState();
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: BackButton(
                      color: accent,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          "Detalles del trabajo",
                          style: TextStyle(
                              fontSize: ancho * .07,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
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
                      border: Border.all(color: Colors.black26),
                      color: background,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: ancho * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(icono, color: primary, size: ancho * .15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "${vacante?.get("Puesto")}",
                              style: TextStyle(fontSize: ancho * .05),
                            ),
                            AutoSizeText(
                              "${vacante?.get("Empresa")}",
                              style: TextStyle(fontSize: ancho * .04),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: alto * .03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AutoSizeText(
                            "Salario",
                            style: TextStyle(fontSize: ancho * .04),
                          ),
                          AutoSizeText(
                            "${vacante?.get("Salario")}",
                            style: TextStyle(
                                color: tertiary, fontSize: ancho * .04),
                          )
                        ],
                      ),
                      const Divider(color: Colors.black26, height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AutoSizeText(
                            "Horario",
                            style: TextStyle(fontSize: ancho * .04),
                          ),
                          AutoSizeText(
                            "${vacante?.get("Horario")}",
                            style: TextStyle(
                                color: tertiary, fontSize: ancho * .04),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AutoSizeText(
                              "Ubicación",
                              style: TextStyle(fontSize: ancho * .04),
                            ),
                            AutoSizeText(
                              "${vacante?.get("Ubicacion")}",
                              style: TextStyle(
                                  color: tertiary, fontSize: ancho * .04),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        alignment: AlignmentDirectional.centerStart,
                        child: AutoSizeText(
                          "Descripción",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ancho * .05,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: AutoSizeText(
                          "${vacante?.get("Descripcion")}",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        alignment: AlignmentDirectional.centerStart,
                        child: AutoSizeText(
                          "Escolaridad",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ancho * .05,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: AutoSizeText(
                          "${vacante?.get("Escolaridad")}",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        alignment: AlignmentDirectional.centerStart,
                        child: AutoSizeText(
                          "Discapacidad",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ancho * .05,
                          ),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: AutoSizeText(
                          "${vacante?.get("Discapacidad")}",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Postulantes(
                              idVacante: vacante!.id,
                              nombreVacante: vacante!.get("Puesto"),
                            ),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(
                          Size(ancho * .8, alto * .06),
                        ),
                      ),
                      child: Text(
                        "Ver Postulantes",
                        style: TextStyle(fontSize: ancho * .05),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
