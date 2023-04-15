import 'package:vitium_app/Funcionalidades/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Empresa extends Usuario {
  String nombreEmpleado = "";
  String numeroDeTelefono = "";
  String empresaAfiliada = "";
  String rfc = "";
  String puesto = "";

  @override
  Future<void> editarCuenta() async {
    final empresa = <String, String>{
      "nombre": nombreEmpleado,
      "numeroDeTelefono": numeroDeTelefono,
      "empresaAfiliada": empresaAfiliada,
      "rfc": rfc,
      "puesto": puesto,
    };

    db
        .collection("empresa")
        .doc(email)
        .set(empresa)
        .onError((error, stackTrace) => {});
  }
}
