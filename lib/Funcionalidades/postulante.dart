import 'package:vitium_app/Funcionalidades/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitium_app/Pantallas/home_user.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

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
}
