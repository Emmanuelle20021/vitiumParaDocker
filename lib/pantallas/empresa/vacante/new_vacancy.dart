import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/vacante.dart';
import 'package:vitium_app/pantallas/empresa/home/home_empresa.dart';
import 'package:vitium_app/pantallas/empresa/vacante/next_vacancy.dart';

import '../../../constantes/constantes.dart';

class NewVacancy extends StatefulWidget {
  const NewVacancy({super.key});

  @override
  State<NewVacancy> createState() => _NewVacancyState();
}

Vacante vacante = Vacante();

class _NewVacancyState extends State<NewVacancy> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _empleoController = TextEditingController();
  final TextEditingController _salarioController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                          "¡Rellena los siguientes campos y publica un nuevo empleo!",
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
                                child: _empleoTextField(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _salarioTextField(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _horarioField(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _ubicacionTextField(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _escolaridadField(),
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

  Widget _empleoTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _empleoController,
            onChanged: (value) {
              vacante.nombreVacante = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingresa el empleo";
              }
              return null;
            },
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              icon: Icon(Icons.work_outline_outlined),
              hintText: "Ejecutivo (a) de ventas",
              labelText: "Nombre de empleo",
            ),
          ),
        );
      },
    );
  }

  Widget _salarioTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _salarioController,
            onChanged: (value) {
              vacante.salario = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingresa el salario";
              }
              return null;
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              icon: Icon(Icons.attach_money_outlined),
              hintText: "4000-5000 MXN    /MENSUAL",
              labelText: "Salario",
            ),
          ),
        );
      },
    );
  }

  Widget _horarioField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.10,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: DropdownButtonFormField(
            items: <String>["Tiempo completo", "Medio tiempo", "Por horas"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
            //controller: _nameController,
            onChanged: (value) {
              vacante.horario = value!;
            },
            validator: (value) {
              if (value == null) {
                return "Seleccione un horario";
              }
              return null;
            },
            decoration: const InputDecoration(
              icon: Icon(Icons.more_time_sharp),
              hintText: "Tiempo completo",
              labelText: "Horario",
            ),
          ),
        );
      },
    );
  }

  Widget _ubicacionTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _ubicacionController,
            onChanged: (value) {
              vacante.ubicacion = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingresa la ubicación";
              }
              return null;
            },
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              icon: Icon(Icons.location_on_outlined),
              hintText: "Coatzacoalcos",
              labelText: "Ubicación",
            ),
          ),
        );
      },
    );
  }

  Widget _escolaridadField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.10,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: DropdownButtonFormField(
            items: <String>[
              "Preparatoria terminada",
              "Preparatoria trunca",
              "Licenciatura",
              "Licenciatura trunca",
              "Sin estudios"
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
            //controller: _nameController,
            onChanged: (value) {
              vacante.escolaridad = value!;
            },
            validator: (value) {
              if (value == null) {
                return "Seleccione la escolaridad";
              }
              return null;
            },
            decoration: const InputDecoration(
              icon: Icon(Icons.school_outlined),
              hintText: "Preparatoria terminada",
              labelText: "Escolaridad",
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
          width: MediaQuery.of(context).size.width * .85,
          height: MediaQuery.of(context).size.height * .06,
          child: FloatingActionButton.extended(
            heroTag: 'boton',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NextVacancy(),
                ),
              );
            },
            label: Text(
              "Siguiente",
              style: buttonTextStyle,
            ),
            elevation: 10,
          ),
        );
      },
    );
  }
}
