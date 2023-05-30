import 'dart:io';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/empresa/postulantes/accepted.dart';

// ignore: must_be_immutable
class DetallePostulado extends StatefulWidget {
  QueryDocumentSnapshot postulante;
  QueryDocumentSnapshot postulacion;
  DetallePostulado(this.postulante, this.postulacion, {super.key});

  @override
  State<DetallePostulado> createState() => _VacantePostuladoState();
}

class _VacantePostuladoState extends State<DetallePostulado> {
  QueryDocumentSnapshot<Object>? vacante;
  FirebaseFirestore db = FirebaseFirestore.instance;
  late IconData icono;
  bool isDownloading = false;

  @override
  initState() {
    icono = iconosPerfiles[Random().nextInt(4 - 0)];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                              "Detalles del postulante",
                              style: TextStyle(
                                  fontSize: ancho * .06,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: alto * .06,
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
                                  softWrap: true,
                                  "${widget.postulante.get("Nombre")}",
                                  style: TextStyle(fontSize: ancho * .05),
                                ),
                                AutoSizeText(
                                  "${widget.postulante.get("Discapacidad")}",
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
                                    widget.postulacion.get("Estado"),
                                    style: TextStyle(
                                        color: getColor(
                                            widget.postulacion.get("Estado")),
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
                                    "Telefono",
                                    style: TextStyle(fontSize: ancho * .06),
                                  ),
                                  AutoSizeText(
                                    "${widget.postulante.get("Telefono")}",
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
                                    "Cumpleaños",
                                    style: TextStyle(fontSize: ancho * .06),
                                  ),
                                  AutoSizeText(
                                    "${widget.postulante.get("FechaNacimiento")}",
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
                                "Currículum adjunto",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ancho * .05,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(ancho * .9, alto * .09),
                                      backgroundColor: Colors.red[100],
                                    ),
                                    onPressed: () {
                                      download(
                                          widget.postulacion.get("Curriculum"),
                                          "CV_${widget.postulante.get("Nombre")}");
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset("assets/defaults/pdf.png",
                                            fit: BoxFit.contain,
                                            height: alto * .07),
                                        const Text(
                                          "Descargar currículum",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  isDownloading
                                      ? const Text("Descarga completa")
                                      : const Text(""),
                                ],
                              ),
                            ),
                            widget.postulacion.get("Estado") == "Pendiente"
                                ? Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: ancho * .1, vertical: alto * .03),
                              width: ancho,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: tertiary,
                                    ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Accepted(
                                                  postulacion:
                                                      widget.postulacion,
                                                  postulante: widget.postulante,
                                                ),
                                              ),
                                            ).whenComplete(
                                              () => Navigator.pop(context),
                                            );
                                          },
                                    child: Text(
                                      "Aceptar",
                                      style: TextStyle(fontSize: alto * .02),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: secondary,
                                    ),
                                          onPressed: () {
                                            rechazar(widget.postulacion);
                                            Navigator.pop(context);
                                          },
                                    child: Text(
                                      "Rechazar",
                                      style: TextStyle(fontSize: alto * .02),
                                    ),
                                  )
                                ],
                              ),
                                  )
                                : const Text(""),
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

  void rechazar(QueryDocumentSnapshot postulacion) {
    final postulante = <String, String>{
      "Curriculum": postulacion.get("Curriculum"),
      "Estado": "Rechazado",
      "Mensaje":
          "Debido a que su perfil no cumple\ncon nuestros requisitos, su solicitud ha sido rechazada.\nTenga buen día.",
      "Postulante": postulacion.get("Postulante"),
      "Vacante": postulacion.get("Vacante")
    };

    db
        .collection("Postulaciones")
        .doc(postulacion.id)
        .set(postulante)
        .onError((error, stackTrace) => {});
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      setState(() {
        isDownloading = true;
      });
    }
  }

  Future download(String url, String filename) async {
    var savePath = '/storage/emulated/0/Download/$filename';
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: null,
        ),
      );
      var file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      debugPrint(e.toString());
    }
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
