import 'package:vitium_app/Funcionalidades/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Postulante extends Usuario {
  String nombre = "";
  String numeroDeTelefono = "";
  String fechaNacimiento = "";
  String descripcion = "";

  @override
  Future<void> registrar() async {
    super.registrar();

    final postulante = <String, String>{
      "nombre": nombre,
      "numeroDeTelefono": numeroDeTelefono,
      "fechaNacimiento": fechaNacimiento,
      "descripcion": descripcion,
    };

    db
        .collection("postulante")
        .doc(email)
        .set(postulante)
        .onError((error, stackTrace) => {});
  }
}
