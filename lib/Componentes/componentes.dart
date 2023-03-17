import 'package:flutter/material.dart';

Widget boton(String texto, Color colorBoton, Color colorTexto) {
  return ElevatedButton(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
    onPressed: () {},
    child: Text(texto),
  );
}
