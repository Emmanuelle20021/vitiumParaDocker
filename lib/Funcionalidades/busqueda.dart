import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Busqueda {
  FirebaseFirestore db = FirebaseFirestore.instance;

  buscarPuesto(busqueda) async {
    await db.collectionGroup("vacantes").get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.toList().forEach((element) {
              // ignore: avoid_print
              String field = element.get("puesto");
              if (field.contains(busqueda)) {
                debugPrint(element.data() as String?);
              }
            })
          },
        );
  }

  buscarEmpresa(busqueda) async {
    await db.collectionGroup("vacantes").get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.toList().forEach((element) {
              // ignore: avoid_print
              String field = element.id;
              if (field.contains(busqueda)) {
                debugPrint(element.data() as String);
              }
            })
          },
        );
  }

  filtrarSalario(salario) async {
    final vacantesFiltradas = await db
        .collection('vacantes')
        .where("salario", isGreaterThanOrEqualTo: salario)
        .get();
    for (var element in vacantesFiltradas.docs) {
      debugPrint(element.data() as String);
    }
  }

  filtrarDiscapacidad(discapacidad) async {
    final vacantesFiltradas = await db
        .collection('vacantes')
        .where("discapacidad", isGreaterThanOrEqualTo: discapacidad)
        .get();
    for (var element in vacantesFiltradas.docs) {
      debugPrint(element.data() as String);
    }
  }
}
