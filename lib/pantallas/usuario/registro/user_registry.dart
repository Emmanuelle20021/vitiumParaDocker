import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/postulante.dart';
import 'package:vitium_app/constantes/constantes.dart';

class UserRegistry extends StatefulWidget {
  static String id = "user_registry";
  const UserRegistry({
    super.key,
  });

  @override
  State<UserRegistry> createState() => _UserRegistryState();
}

class _UserRegistryState extends State<UserRegistry> {
  Postulante usuario = Postulante();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _birthController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final largo = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              width: ancho,
              child: Image.asset(fondo_2,
                  alignment: Alignment.topCenter, fit: BoxFit.cover),
            ),
            Column(
              children: [
                SizedBox(
                  height: largo * 0.32,
                ),
                Form(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _nameTextField(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget _nameTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.04,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _nameController,
            onChanged: (value) {
              value;
              usuario.nombre;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingrese su nombre";
              }
              return null;
            },
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              hintText: "Nombre completo",
              hintStyle: TextStyle(height: BorderSide.strokeAlignOutside),
              labelText: "Nombre completo",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
