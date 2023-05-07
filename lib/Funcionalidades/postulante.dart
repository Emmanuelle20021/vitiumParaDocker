import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vitium_app/Funcionalidades/postulacion.dart';
import 'package:vitium_app/Funcionalidades/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart' show user;

FirebaseFirestore db = FirebaseFirestore.instance;
Postulacion postulacion = Postulacion();

class Postulante extends Usuario {
  String nombre = "";
  String numeroDeTelefono = "";
  String fechaNacimiento = "";
  String descripcion = "";

  String cv = "";

  @override
  Future<void> registrar() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await super.registrar();
    User? user = auth.currentUser;
    user?.updatePhotoURL("Postulante");
  }

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

  Future<void> postular(vacante) async {
    final postulacion = <String, String>{
      "curriculum": cv,
    };
    db
        .collection("postulaciones")
        .doc(vacante)
        .set(postulacion)
        .onError((error, stackTrace) => {});
  }

  Future<void> subirCV(filePaht) async {
    File file = File(filePaht);
    final storageRef = FirebaseStorage.instance.ref();
    final folderRef = storageRef.child("${user?.uid}");
    final cvRef = folderRef.child("CV.pdf");

    try {
      await cvRef.putFile(file);
      cv = await cvRef.getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint("peto $e");
    }
  }
}
