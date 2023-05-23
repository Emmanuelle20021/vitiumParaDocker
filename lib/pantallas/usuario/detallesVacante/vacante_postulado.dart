import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:vitium_app/constantes/constantes.dart';

// ignore: must_be_immutable
class VacantePostulado extends StatefulWidget {
  String idVacante;
  bool isPostulado;
  String estado;
  String mensaje;
  VacantePostulado(this.idVacante, this.isPostulado, this.estado, this.mensaje,
      {super.key});

  @override
  State<VacantePostulado> createState() => _VacantePostuladoState();
}

class _VacantePostuladoState extends State<VacantePostulado> {
  late ConfettiController _controllerCenter;
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
    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 2, milliseconds: 500),
    );
    if (widget.estado == "Aceptado") {
      _controllerCenter.play();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controllerCenter.dispose();
  }

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
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
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality.explosive,
                    colors: [
                      primary,
                      accent,
                      tertiary,
                      secondary,
                    ],
                    createParticlePath: drawStar,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
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
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: alto * .07,
                                child: Image.asset(logoVitium,
                                    fit: BoxFit.contain),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: alto * .1,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
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
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: alto * .03,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(
                                    "Estado",
                                    style: TextStyle(fontSize: ancho * .06),
                                  ),
                                  AutoSizeText(
                                    widget.estado,
                                    style: TextStyle(
                                        color: getColor(widget.estado),
                                        fontSize: ancho * .05),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(
                                    "Horario",
                                    style: TextStyle(fontSize: ancho * .06),
                                  ),
                                  AutoSizeText(
                                    "${vacante?.get("Horario")}",
                                    style: TextStyle(
                                        color: tertiary, fontSize: ancho * .05),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(
                                    "Ubicación",
                                    style: TextStyle(fontSize: ancho * .06),
                                  ),
                                  AutoSizeText(
                                    "${vacante?.get("Ubicacion")}",
                                    style: TextStyle(
                                        color: tertiary, fontSize: ancho * .05),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              alignment: AlignmentDirectional.centerStart,
                              child: AutoSizeText(
                                "Detalles de solicitud",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ancho * .05,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: AutoSizeText(
                                widget.mensaje,
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: ancho * .04),
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Color getColor(estado) {
    Color color;
    switch (estado) {
      case "Rechazado":
        color = Colors.red.shade300;
        break;
      case "Aceptado":
        color = tertiary;
        break;
      default:
        color = secondary;
    }
    return color;
  }
}
