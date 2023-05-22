import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vitium_app/constantes/constantes.dart';

// ignore: must_be_immutable
class DetalleVacante extends StatefulWidget {
  String idVacante;
  bool isPostulado;
  DetalleVacante(this.idVacante, this.isPostulado, {super.key});

  @override
  State<DetalleVacante> createState() => _DetalleVacanteState();
}

class _DetalleVacanteState extends State<DetalleVacante> {
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
    super.initState();
    buscarVacante(widget.idVacante);
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        "Detalles del trabajo",
                        style: TextStyle(
                            fontSize: ancho * .07, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: alto * .09,
                        child: Image.asset(logoVitium),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    color: background,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(5, 10),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: ancho * 0.1),
                  child: Row(
                    children: [
                      Icon(icono),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
