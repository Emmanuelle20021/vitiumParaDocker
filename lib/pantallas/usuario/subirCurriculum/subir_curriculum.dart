import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart';

// ignore: must_be_immutable
class SubirCv extends StatefulWidget {
  String id;
  String vacante;
  SubirCv({required this.id, required this.vacante, super.key});

  @override
  State<SubirCv> createState() => _SubirCvState();
}

FirebaseFirestore db = FirebaseFirestore.instance;
PlatformFile archivo = PlatformFile(name: "No seleccionado", size: 0);
String? cv;

class _SubirCvState extends State<SubirCv> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: accent),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Carga tu currículum",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * .03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(logoVitium,
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height * .06),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Agrega tu curriculum para tener mayores oportunidades de ser seleccionado.",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * .019,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .13,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50],
                  fixedSize: Size(MediaQuery.of(context).size.width * .9,
                      MediaQuery.of(context).size.height * .15),
                ),
                onPressed: () {
                  openFile();
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/defaults/pdf.png",
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height * .08,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    archivo.name == "No seleccionado"
                        ? AutoSizeText(
                            "Sube tu curriculum",
                            softWrap: true,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            "${archivo.name}\n${archivo.size}kbs",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    subirCV(archivo.path).whenComplete(
                      () => Navigator.pop(context),
                    );
                  },
                  child: Text(
                    "Postularce",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.025),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void postular() {
    cv == null ? cv = "" : cv = cv;

    final postulacion = <String, String>{
      "Estado": "Pendiente",
      "Mensaje": "Solicitud en proceso de revisión",
      "Postulante": widget.id,
      "Vacante": widget.vacante,
      "Curriculum": cv!
    };

    db
        .collection("Postulaciones")
        .doc()
        .set(postulacion)
        .onError((error, stackTrace) => {});
  }

  openFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }
    setState(() {
      archivo = result.files.first;
    });
  }

  Future<void> subirCV(filePaht) async {
    File file = File(filePaht);
    final storageRef = FirebaseStorage.instance.ref();
    final folderRef = storageRef.child("${user?.uid}");
    final cvRef = folderRef.child("CV.pdf");

    try {
      cvRef.putFile(file).whenComplete(
            () async => cv = await cvRef.getDownloadURL().whenComplete(
                  () => postular(),
                ),
          );
    } catch (e) {
      debugPrint("peto $e");
    }
  }
}
