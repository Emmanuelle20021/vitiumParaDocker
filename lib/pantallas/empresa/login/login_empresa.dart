import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/empresa.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/empresa/registro/registro_empresa.dart';
import 'package:vitium_app/pantallas/usuario/login/login_user.dart';

class LoginEmpresa extends StatefulWidget {
  const LoginEmpresa({super.key});

  @override
  State<LoginEmpresa> createState() => _LoginEmpresaState();
}

Empresa usuario = Empresa();

class _LoginEmpresaState extends State<LoginEmpresa> {
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
    final alto = MediaQuery.of(context).size.height;
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
              Column(
                mainAxisSize: MainAxisSize.max,
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
                    padding: EdgeInsets.only(bottom: alto * 0.15, left: 20),
                    alignment: Alignment.bottomLeft,
                    child: AutoSizeText(
                      "Iniciar sesión",
                      style: tituloStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _userTextField(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 20, right: 8, left: 8),
                            child: _passwordTextField(),
                          ),
                          Center(
                            child: _buttonSend(),
                          ),
                          Center(
                            child: _lostPassword(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Hero(
                                  tag: 'I',
                                  child: DottedLine(
                                    lineLength: ancho * 0.4,
                                    dashColor: primary,
                                    direction: Axis.horizontal,
                                  ),
                                ),
                                const Text(
                                  " ó ",
                                ),
                                DottedLine(
                                  lineLength: ancho * 0.4,
                                  dashColor: primary,
                                  direction: Axis.horizontal,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: _registroButton(),
                          ),
                          _postulanteButton(),
                        ],
                      ),
                    ),
                  ),
                ],
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

  _postulanteButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .7,
      height: MediaQuery.of(context).size.height * .06,
      child: FloatingActionButton.extended(
        heroTag: 'postulante',
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginUser(),
            ),
          );
        },
        label: Text(
          "Soy postulante",
          style: buttonTextStyle,
        ),
        elevation: 10,
      ),
    );
  }

  _registroButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .7,
      height: MediaQuery.of(context).size.height * .06,
      child: FloatingActionButton.extended(
        heroTag: 'registro',
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const RegistroEmpresa(),
              ));
        },
        label: Text(
          "¿Aún no tienes cuenta?",
          style: buttonTextStyle,
        ),
        elevation: 10,
      ),
    );
  }

  _lostPassword() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .7,
      height: MediaQuery.of(context).size.height * .06,
      child: TextButton(
        onPressed: () {},
        child: Text(
          "¿Olvidaste tu contraseña?",
          style: textButtonStyle,
        ),
      ),
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
        heroTag: 'boton',
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
