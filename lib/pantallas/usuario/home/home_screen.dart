import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/usuario/detallesVacante/detalles_vacante.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart';
import 'package:vitium_app/pantallas/usuario/home/trabajos_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double anchoGlobal;
  late IconData icono;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<FichaEmpresa> empresas = List.empty(growable: true);
  String busqueda = "";

  void setGlobal(ancho) {
    anchoGlobal = ancho;
  }

  @override
  void initState() {
    rellenarEmpresas("");
    super.initState();
    FlutterNativeSplash.remove();
    buscarVacante();
    icono = iconos[Random().nextInt(6 - 0)];
  }

  QueryDocumentSnapshot<Object>? vacante;

  buscarVacante() async {
    icono = iconos[Random().nextInt(6 - 0)];
    vacante = null;
    QueryDocumentSnapshot<Object>? vacantes;
    await db.collectionGroup("Vacantes").get().then(
          (value) => {
            value.docs.toList().forEach((element) {
              if (vacante == null) {
                vacantes = element;
              }
            })
          },
        );
    setState(() {
      vacante ??= vacantes;
    });
  }

  Future<Type> rellenarEmpresas(busqueda) async {
    refreshKey.currentState?.show();
    List<FichaEmpresa> empresa = List.empty(growable: true);
    await db.collectionGroup("Empresa").get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.toList().forEach(
              (element) {
                String nombre = element.get("Nombre");
                if (nombre.contains(busqueda)) {
                  FichaEmpresa fichaEmpresa = FichaEmpresa(
                    element.get("Imagen"),
                    element.get("Nombre"),
                  );
                  empresa.add(fichaEmpresa);
                }
              },
            ),
          },
        );
    setState(() {
      empresas = List.empty(growable: true);
      empresas = empresa;
    });
    return Null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController busquedaController = TextEditingController();
    double ancho = MediaQuery.of(context).size.width;
    double alto = MediaQuery.of(context).size.height;
    setGlobal(ancho);
    return SingleChildScrollView(
      child: RefreshIndicator(
        key: refreshKey,
        onRefresh: () => rellenarEmpresas(busqueda),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: alto * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  flex: 2,
                  child: AutoSizeText.rich(
                    textAlign: TextAlign.justify,
                    maxFontSize: 33,
                    minFontSize: 30,
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Descubre tu \n",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "Trabajo favorito",
                          style: TextStyle(color: accent),
                        ),
                      ],
                    ),
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
                        rellenarEmpresas(busqueda);
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
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              alignment: Alignment.centerLeft,
              child: const AutoSizeText(
                "Nuestras Empresas",
                minFontSize: 15,
                maxFontSize: 25,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: alto * 0.44,
              child: Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: compruebaEmpresas(empresas, alto, ancho),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AutoSizeText(
                    "Más recientes",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: () {},
                    child: const AutoSizeText("Ver todos"),
                  ),
                ],
              ),
            ),
            vacanteFicha(),
          ],
        ),
      ),
    );
  }

  Widget compruebaEmpresas(empresas, alto, ancho) => empresas != Null
      ? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          padding: const EdgeInsets.all(20),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: empresas.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrabajosScreen(
                      empresas[index].nombre,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: ancho * 0.3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: ancho * 0.3,
                      decoration: BoxDecoration(
                        color: background,
                        border: Border.all(color: Colors.black),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20,
                            offset: Offset(8, 7),
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                      ),
                      height: alto * 0.1,
                      child: Image.asset(
                        logoVitium,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20,
                            offset: Offset(8, 7),
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                        color: accent,
                      ),
                      height: alto * 0.045,
                      width: ancho * 0.3,
                      alignment: Alignment.center,
                      child: Text(
                        empresas[index].nombre,
                        style: TextStyle(color: background),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
      : const Center(
          child: Text("No hay empresas para mostrar"),
        );

  Widget vacanteFicha() => vacante != null
      ? GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetalleVacante(vacante!.id, false);
                },
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                side: BorderSide(width: .3, color: Colors.grey),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(icono, color: primary, weight: anchoGlobal * .17),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vacante?.get("Puesto"),
                            textAlign: TextAlign.start),
                        Text(
                          vacante?.get("Empresa"),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(vacante?.get("Discapacidad")),
                    const Spacer(),
                    Text(vacante?.get("Salario")),
                  ],
                )
              ],
            ),
          ),
        )
      : const Center(child: Text("No hay vacantes"));
}
