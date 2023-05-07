import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/constantes/constantes.dart';

class HomeUsuario extends StatefulWidget {
  const HomeUsuario({super.key});

  @override
  State<HomeUsuario> createState() => _HomeUsuarioState();
}

FirebaseFirestore db = FirebaseFirestore.instance;
List<FichaEmpresa> empresas = List.empty(growable: true);

rellenarEmpresas() async {
  empresas = List.empty(growable: true);
  await db.collectionGroup("Empresa").get().then(
        (QuerySnapshot querySnapshot) => {
          querySnapshot.docs.toList().forEach(
            (element) {
              FichaEmpresa fichaEmpresa = FichaEmpresa(
                element.get("Imagen"),
                element.get("Nombre"),
              );
              empresas.add(fichaEmpresa);
            },
          ),
        },
      );
}

final User? user = FirebaseAuth.instance.currentUser;

class _HomeUsuarioState extends State<HomeUsuario> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    double alto = MediaQuery.of(context).size.height;
    TextEditingController busquedaController = TextEditingController();
    return Scaffold(
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
            height: alto * 0.4,
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
          )
        ],
      ),
    );
  }
}

Widget compruebaEmpresas(empresas, alto, ancho) {
  rellenarEmpresas();
  if (empresas.length > 0) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      padding: const EdgeInsets.all(20),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: empresas.length,
      itemBuilder: (context, index) {
        return Container(
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
                height: alto * 0.05,
                width: ancho * 0.3,
                alignment: Alignment.center,
                child: Text(
                  empresas[index]._nombre,
                  style: TextStyle(color: background),
                ),
              ),
            ],
          ),
        );
      },
    );
  } else {
    return const Text("No hay empresas para mostrar");
  }
}

class FichaEmpresa {
  String _img = '';
  String _nombre = '';

  FichaEmpresa(img, nombre) {
    _img = img;
    _nombre = nombre;
  }

  // getters
  get img => _img;
  get nombre => _nombre;
}
