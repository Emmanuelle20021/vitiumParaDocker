import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/empresa/postulantes/detalle_postulado.dart';

// ignore: must_be_immutable
class Postulantes extends StatelessWidget {
  String idVacante;
  String nombreVacante;
  Postulantes(
      {required this.idVacante, required this.nombreVacante, super.key});

  @override
  Widget build(BuildContext context) {
    Size tam = MediaQuery.of(context).size;
    double alto = tam.height;
    double ancho = tam.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: accent,
                size: alto * 0.03,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: AutoSizeText.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Postulantes \n",
                          style: TextStyle(fontSize: alto * .05),
                        ),
                        TextSpan(
                          text: nombreVacante,
                          style:
                              TextStyle(color: accent, fontSize: alto * .023),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: alto * .1,
                  width: ancho * .2,
                  child: Image.asset(logoVitium, fit: BoxFit.contain),
                ),
              ],
            ),
            SizedBox(
              height: alto * .03,
            ),
            SizedBox(
              height: alto * .75,
              child: Postulacion(idVacante: idVacante),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Postulacion extends StatefulWidget {
  String idVacante;
  Postulacion({required this.idVacante, super.key});

  @override
  State<Postulacion> createState() => _PostulacionState();
}

late IconData icono;
List<QueryDocumentSnapshot<Object>>? postulantes;
List<QueryDocumentSnapshot<Object>>? postulaciones;
FirebaseFirestore db = FirebaseFirestore.instance;

class _PostulacionState extends State<Postulacion> {
  buscarPostulacion() async {
    icono = iconosPerfiles[Random().nextInt(4 - 0)];
    postulaciones = null;
    postulantes = null;
    List<QueryDocumentSnapshot<Object>>? postulacion =
        List.empty(growable: true);
    List<QueryDocumentSnapshot<Object>>? postulante =
        List.empty(growable: true);
    await db.collectionGroup("Postulaciones").get().then(
          (value) => {
            value.docs.toList().forEach(
              (element) {
                String comp = element.get('Vacante');
                String aux = widget.idVacante;
                if (aux == comp) {
                  postulacion.add(element);
                }
              },
            ),
          },
        );
    await db.collection("Perfil").get().then(
          (value) => {
            if (postulacion.isNotEmpty)
              value.docs.toList().forEach(
                (element) {
                  String comp = element.reference.id;
                  for (var post in postulacion) {
                    String aux = post.get("Postulante");
                    if (aux == comp) {
                      postulante.add(element);
                    }
                  }
                },
              ),
          },
        );
    setState(() {
      postulaciones ??= postulacion;
      postulantes = postulante;
    });
  }

  @override
  void initState() {
    super.initState();
    buscarPostulacion();
  }

  @override
  Widget build(BuildContext context) => (postulantes == null ||
          postulantes!.isEmpty)
      ? SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Aún no hay postulantes"),
            ],
          ),
        )
      : ListView.builder(
          itemCount: postulantes?.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallePostulado(
                    postulantes![index],
                    postulaciones![index],
                  ),
                ),
              ).whenComplete(
                () => buscarPostulacion(),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(icono,
                            size: MediaQuery.of(context).size.width * .1,
                            color: tertiary),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              postulantes?[index].get("Nombre"),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * .04),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 5),
                          width: MediaQuery.of(context).size.width * .3,
                          height: MediaQuery.of(context).size.height * .03,
                          decoration: BoxDecoration(
                            color:
                                getColor(postulaciones?[index].get("Estado")),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 15,
                                color: background,
                              ),
                              AutoSizeText(
                                postulaciones?[index].get("Estado"),
                                style: TextStyle(color: background),
                              ),
                            ],
                          ),
                        )
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
                            "Discapacidad ${postulantes?[index].get("Discapacidad")}",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );

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
