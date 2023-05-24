import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/usuario/detallesVacante/vacante_postulado.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart';

class Postulaciones extends StatelessWidget {
  const Postulaciones({super.key});

  @override
  Widget build(BuildContext context) {
    Size tam = MediaQuery.of(context).size;
    double alto = tam.height;
    double ancho = tam.width;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AutoSizeText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Trabajos\n",
                      style: TextStyle(fontSize: alto * .05),
                    ),
                    TextSpan(
                      text: "Postulados",
                      style: TextStyle(color: accent, fontSize: alto * .05),
                    ),
                  ],
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
            height: alto * .08,
          ),
          SizedBox(height: alto * .63, child: const Postulacion()),
        ],
      ),
    );
  }
}

class Postulacion extends StatefulWidget {
  const Postulacion({super.key});

  @override
  State<Postulacion> createState() => _PostulacionState();
}

late IconData icono;
List<QueryDocumentSnapshot<Object>>? vacantes;
List<QueryDocumentSnapshot<Object>>? postulaciones;
FirebaseFirestore db = FirebaseFirestore.instance;

class _PostulacionState extends State<Postulacion> {
  buscarPostulacion() async {
    icono = iconos[Random().nextInt(6 - 0)];
    postulaciones = null;
    vacantes = null;
    List<QueryDocumentSnapshot<Object>>? postulacion =
        List.empty(growable: true);
    List<QueryDocumentSnapshot<Object>>? vacante = List.empty(growable: true);
    await db.collectionGroup("Postulaciones").get().then(
          (value) => {
            value.docs.toList().forEach(
              (element) {
                String comp = element.get('Postulante');
                String aux = user!.uid;
                if (aux == comp) {
                  postulacion.add(element);
                }
              },
            ),
          },
        );
    await db.collection("Vacantes").get().then(
          (value) => {
            if (postulacion.isNotEmpty)
              value.docs.toList().forEach(
                (element) {
                  String comp = element.reference.id;
                  for (var post in postulacion) {
                    String aux = post.get("Vacante");
                    if (aux == comp) {
                      vacante.add(element);
                    }
                  }
                },
              ),
          },
        );
    setState(() {
      postulaciones ??= postulacion;
      vacantes = vacante;
    });
  }

  @override
  void initState() {
    super.initState();
    buscarPostulacion();
  }

  @override
  Widget build(BuildContext context) => vacantes == null
      ? const Text("Aún no te has postulado")
      : ListView.builder(
          itemCount: vacantes?.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VacantePostulado(
                    vacantes![index].id,
                    true,
                    postulaciones![index].get("Estado"),
                    postulaciones![index].get("Mensaje"),
                  ),
                ),
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
                              vacantes?[index].get("Puesto"),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * .04),
                            ),
                            Text(
                              vacantes?[index].get('Empresa'),
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
                            "Discapacidad ${vacantes?[index].get("Discapacidad")}",
                          ),
                        ),
                        Text(
                          vacantes?[index].get("Salario"),
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
