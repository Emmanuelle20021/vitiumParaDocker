import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vitium_app/Funcionalidades/vacante.dart';
import 'package:vitium_app/pantallas/empresa/home/home_empresa.dart';
import 'package:vitium_app/pantallas/empresa/vacante/new_vacancy.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart';

import '../../../constantes/constantes.dart';

// ignore: must_be_immutable
class NextVacancy extends StatefulWidget {
  Vacante vacante;
  NextVacancy(this.vacante, {super.key});

  @override
  State<NextVacancy> createState() => _NextVacancyState();
}

FirebaseFirestore db = FirebaseFirestore.instance;

int? _value = 1;
// ignore: prefer_typing_uninitialized_variables
var busqueda;
List<String> discapacidades = <String>[
  "física",
  "motriz",
  "auditiva",
  "del habla"
];

class _NextVacancyState extends State<NextVacancy> {
  buscarVacante() async {
    var busquedaAux = "";
    String id = user!.uid;
    await db.collectionGroup("Reclutador").get().then(
          (value) => {
            value.docs.toList().forEach(
              (element) async {
                if (element.id == id) {
                  busquedaAux = element.get('Empresa afiliada');
                }
              },
            ),
          },
        );
    setState(() {
      busqueda = busquedaAux;
    });
  }

  @override
  void initState() {
    buscarVacante();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    busqueda ??= buscarVacante();
    Size tam = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Stack(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeEnterprise(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_back_sharp),
                            color: primary,
                          ),
                          Image.asset(logoVitium, width: tam.width * 0.15),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Publicar",
                          style: TextStyle(fontSize: tam.width * 0.08),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "nuevo empleo",
                          style: TextStyle(
                              fontSize: tam.width * 0.07, color: primary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "¡Rellena la descripción del nuevo empleo!",
                          style: TextStyle(fontSize: tam.width * 0.04),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _descripcionTextField(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 90.0, bottom: 10, top: 10),
                                child: _titleChip(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 90.0),
                                child: _discapacidadAdmitida(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: _buttonSSiguiente(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _descripcionTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _descripcionController,
            onChanged: (value) {
              widget.vacante.descripcion = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingresa la descripción";
              }
              return null;
            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              alignLabelWithHint: false,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              hintText: "Experiencia\n\nHabilidades\n\nContratación",
              labelText: "Descripción",
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

  Widget _buttonSSiguiente() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * .80,
          height: MediaQuery.of(context).size.height * .06,
          child: FloatingActionButton.extended(
            heroTag: 'boton',
            onPressed: () {
              aceptar(vacante);
              Navigator.pop(context);
            },
            label: Text(
              "Publicar",
              style: buttonTextStyle,
            ),
            elevation: 10,
          ),
        );
      },
    );
  }

  Widget _discapacidadAdmitida() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(
                4,
                (int index) {
                  return ChoiceChip(
                    label: Text('Discapacidad ${discapacidades[index]}'),
                    labelStyle: TextStyle(color: background),
                    backgroundColor: const Color.fromARGB(255, 132, 129, 129),
                    // ignore: unrelated_type_equality_checks
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        vacante.discapacidadesPermitidas.add(
                          discapacidades[index],
                        );
                        _value = (selected ? index : null);
                      });
                    },
                    selectedColor: primary,
                  );
                },
              ).toList(),
            ),
          ],
        );
      },
    );
  }

  void aceptar(Vacante vacante) {
    busqueda ??= buscarVacante();

    final vacancy = <String, String>{
      "Descripcion": vacante.descripcion,
      "Discapacidad": vacante.discapacidadesPermitidas[0],
      "Empresa": busqueda!.toString(),
      "Escolaridad": vacante.escolaridad,
      "Horario": vacante.horario,
      "Puesto": vacante.nombreVacante,
      "Salario": vacante.salario,
      "Ubicacion": vacante.ubicacion,
    };

    db
        .collection("Vacantes")
        .doc()
        .set(vacancy)
        .onError((error, stackTrace) => {});
  }

  Widget _titleChip() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return const Text(
        "Discapacidades Permitidas",
        textAlign: TextAlign.start,
      );
    });
  }
}
