import 'package:firebase_auth/firebase_auth.dart';

class Usuario {
  String email = "";
  String password = "";
  String fotoPerfil = "";

  @override
  String toString() {
    return "email: $email password: $password";
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registrar() async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> iniciarSesion() async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
