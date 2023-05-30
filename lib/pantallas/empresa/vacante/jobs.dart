import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/usuario/detallesVacante/detalles_vacante.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart';

// ignore: must_be_immutable
class Jobs extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Jobs({super.key});
  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  String busqueda = "";
  TextEditingController busquedaController = TextEditingController();
  late IconData icono;
  List<QueryDocumentSnapshot<Object>>? vacante;
  FirebaseFirestore db = FirebaseFirestore.instance;

  buscarVacante(busqueda) async {
    icono = iconos[Random().nextInt(6 - 0)];
    vacante = null;
    String id = user!.uid;
    await db.collectionGroup("Reclutador").get().then(
          (value) => {
            value.docs.toList().forEach(
              (element) {
                if (element.id == id) {
                  busqueda = element.get('Empresa afiliada');
                }
              },
            ),
          },
        );
    List<QueryDocumentSnapshot<Object>>? vacantes = List.empty(growable: true);
    await db.collectionGroup("Vacantes").get().then(
          (value) => {
            value.docs.toList().forEach((element) {
              String comp = element.get('Empresa');
              if (comp.contains(busqueda)) {
                vacantes.add(element);
              }
            })
          },
        );
    setState(() {
      vacante ??= vacantes;
    });
  }

  @override
  void initState() {
    FlutterNativeSplash.remove();
    buscarVacante(busqueda);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    double alto = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: alto * 0.08,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Flexible(
                fit: FlexFit.loose,
                flex: 2,
                child: AutoSizeText(
                  'Trabajos publicados',
                  maxFontSize: 33,
                  minFontSize: 30,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(logoVitium),
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
                child: Text(
                  vacante != null
                      ? "${vacante?.length} Trabajos publicados"
                      : '0 Trabajos publicados',
                  style: TextStyle(fontSize: ancho * .04),
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
          SizedBox(
            height: alto * .65,
            child: listaTrabajos(alto, ancho),
          ),
        ],
      ),
    );
  }

  Widget listaTrabajos(alto, ancho) => vacante != null
      ? ListView.builder(
          itemCount: vacante?.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DetalleVacante(vacante![index].id, false);
                    },
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(icono, size: ancho * .1, color: tertiary),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vacante?[index].get("Puesto"),
                              style: TextStyle(fontSize: ancho * .05),
                            ),
                            Text(
                              vacante?[index].get('Empresa'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Discapacidad ${vacante?[index].get("Discapacidad")}",
                          ),
                        ),
                        Text(
                          vacante?[index].get("Salario"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        )
      : const Text("No hay trabajos publicados");
}
