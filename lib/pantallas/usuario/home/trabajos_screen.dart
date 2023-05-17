import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vitium_app/constantes/constantes.dart';

// ignore: must_be_immutable
class TrabajosScreen extends StatefulWidget {
  String busquedaini;
  TrabajosScreen(this.busquedaini, {super.key});
  @override
  State<TrabajosScreen> createState() => _TrabajosScreenState();
}

class _TrabajosScreenState extends State<TrabajosScreen> {
  String busqueda = "";
  TextEditingController busquedaController = TextEditingController();
  late IconData icono;
  List<QueryDocumentSnapshot<Object>>? vacante;
  FirebaseFirestore db = FirebaseFirestore.instance;

  buscarVacante(busqueda) async {
    icono = iconos[Random().nextInt(6 - 0)];
    vacante = null;
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
    super.initState();
    busqueda = widget.busquedaini;
    buscarVacante(busqueda);
  }

  @override
  void dispose() {
    super.dispose();
    busquedaController.dispose();
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
            height: alto * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Flexible(
                fit: FlexFit.loose,
                flex: 2,
                child: AutoSizeText(
                  'Resultados',
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  flex: 2,
                  child: TextField(
                    onSubmitted: (value) {
                      busqueda = value;
                      buscarVacante(busqueda);
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                    textCapitalization: TextCapitalization.words,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      constraints: BoxConstraints.tightFor(height: 47),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Buscar",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    controller: busquedaController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: accent,
                    ),
                    child: IconButton(
                      color: background,
                      splashRadius: 20,
                      onPressed: () {},
                      icon: const Icon(Icons.format_list_bulleted_sharp),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                vacante != null
                    ? "${vacante?.length} Trabajos encontrados"
                    : '0 Trabajos encontrados',
                style: TextStyle(fontSize: ancho * .04),
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
              onTap: () {},
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
      : const Text("No hay vacantes");
}
