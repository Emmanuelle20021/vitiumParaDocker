import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/postulante.dart';
import 'package:vitium_app/constantes/constantes.dart';

class LoginUser extends StatefulWidget {
  static String id = "login_user";

  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

Postulante usuario = Postulante();

class _LoginUserState extends State<LoginUser> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    await usuario.iniciarSesion();
  }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Stack(
            children: [
              SizedBox(
                width: ancho,
                child: Image.asset(fondo, fit: BoxFit.cover),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 35, right: 20),
                      alignment: Alignment.centerRight,
                      width: ancho,
                      child: AutoSizeText(
                        "Vitium",
                        maxFontSize: maxFontSizeVitium,
                        style: vitiumStyle,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10, left: 10),
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        "¡Bienvenido de vuelta!",
                        maxFontSize: maxFontSizeSubTitle,
                        style: subtituloStyle,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 20),
                      alignment: Alignment.bottomLeft,
                      child: AutoSizeText(
                        "Iniciar sesión",
                        style: tituloStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _userTextField(),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 20, right: 8, left: 8),
                      child: _passwordTextField(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buttonSend(),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _emailController,
            onChanged: (value) {
              usuario.email = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingresa tu correo";
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              hintText: "ejemplo@correo.com",
              labelText: "Correo electronico",
            ),
          ),
        );
      },
    );
  }

  Widget _passwordTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _passwordController,
            onChanged: (value) {
              usuario.password = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingresa tu contraseña";
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              hintText: "contraseña",
              labelText: "Contraseña",
            ),
          ),
        );
      },
    );
  }

  Widget _buttonSend() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return _buttonRS();
    });
  }

  _buttonRS() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .7,
      height: MediaQuery.of(context).size.height * .06,
      child: FloatingActionButton.extended(
        onPressed: () {
          handleSubmit();
        },
        label: Text(
          "Iniciar Sesión",
          style: buttonTextStyle,
        ),
        elevation: 10,
      ),
    );
  }
}
