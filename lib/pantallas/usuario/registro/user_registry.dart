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
    final tam = largo * .20;
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              width: ancho,
              height: largo * .3,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: tertiary,
                      borderRadius: const BorderRadiusDirectional.vertical(
                        bottom: Radius.elliptical(180, 70),
                      ),
                    ),
                    height: largo * .20,
                  ),
                  Positioned(
                    left: ancho * 0.30,
                    top: largo * 0.10,
                    child: Container(
                      height: tam,
                      width: tam,
                      decoration: BoxDecoration(
                        color: background,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        color: accent,
                        Icons.account_circle,
                        size: tam,
                      ),
                    ),
                  ),
                ],
              ),
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
          height: MediaQuery.of(context).size.height * 0.05,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
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
              alignLabelWithHint: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText: "Bief Case",
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

  /*Widget _buildBirthday() {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: accent,
      weekdayLabels: ['Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab', 'Dom'],
      disabledDayTextStyle: const TextStyle(color: text),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10,),
        CalendarDatePicker2(config: 
        ,)
      ],
    )
  }*/
}
