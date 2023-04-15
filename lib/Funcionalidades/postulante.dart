// ignore_for_file: avoid_print

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vitium_app/Funcionalidades/postulacion.dart';
import 'package:vitium_app/Funcionalidades/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitium_app/Pantallas/home_user.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
Postulacion postulacion = Postulacion();

class Postulante extends Usuario {
  String nombre = "";
  String numeroDeTelefono = "";
  String fechaNacimiento = "";
  String descripcion = "";

  @override
  Future<void> editarCuenta() async {
    final postulante = <String, String>{
      "nombre": nombre,
      "numeroDeTelefono": numeroDeTelefono,
      "fechaNacimiento": fechaNacimiento,
      "descripcion": descripcion,
    };

    db
        .collection("postulante")
        .doc(user?.uid)
        .set(postulante)
        .onError((error, stackTrace) => {});
  }

  Future<void> subirCV(filePaht) async {
    File file = File(filePaht);
    final storageRef = FirebaseStorage.instance.ref();
    final folderRef = storageRef.child("${user?.uid}");
    final cvRef = folderRef.child("CV.pdf");

    try {
      await cvRef.putFile(file);
    } on FirebaseException catch (e) {
      print("peto $e");
    }
  }
}
