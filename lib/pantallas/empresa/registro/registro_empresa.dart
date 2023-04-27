import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/Funcionalidades/empresa.dart';
import 'package:vitium_app/constantes/constantes.dart';

class RegistroEmpresa extends StatefulWidget {
  static String id = "registro_empresa";

  const RegistroEmpresa({super.key});

  @override
  State<RegistroEmpresa> createState() => _RegistroEmpresaState();
}

Empresa usuario = Empresa();

class _RegistroEmpresaState extends State<RegistroEmpresa> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _rfcController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    await usuario.registrar();
  }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _rfcController.dispose();
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
                      "¡Unete a nosotros!",
                      maxFontSize: maxFontSizeSubTitle,
                      style: subtituloStyle,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: alto * 0.15, left: 20),
                    alignment: Alignment.bottomLeft,
                    child: AutoSizeText(
                      "Registrate",
                      style: tituloStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Form(
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
                                bottom: 8, right: 8, left: 8),
                            child: _rfcTextField(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8, right: 8, left: 8),
                            child: _passwordTextField(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 15, right: 8, left: 8),
                            child: _confirmPasswordTextField(),
                          ),
                          Center(
                            child: _buttonSend(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                DottedLine(
                                  lineLength: ancho * 0.4,
                                  dashColor: primary,
                                  direction: Axis.horizontal,
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
                            padding: const EdgeInsets.all(8),
                            child: _loginButton(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: _postulanteButton(),
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
      ),
    );
  }

  Widget _rfcTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _rfcController,
            onChanged: (value) {
              usuario.rfc = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingresa tu RFC";
              }
              return null;
            },
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(Icons.work),
              hintText: "K293021",
              labelText: "Codigo de Empresa",
            ),
          ),
        );
      },
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

  Widget _confirmPasswordTextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: _confirmPasswordController,
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
        onPressed: () {},
        label: Text(
          "Soy postulante",
          style: buttonTextStyle,
        ),
        elevation: 10,
      ),
    );
  }

  _loginButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .7,
      height: MediaQuery.of(context).size.height * .06,
      child: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          "¿Ya tienes cuenta?",
          style: buttonTextStyle,
        ),
        elevation: 10,
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
        onPressed: () {
          handleSubmit();
        },
        label: Text(
          "Registrarse",
          style: buttonTextStyle,
        ),
        elevation: 10,
      ),
    );
  }
}
