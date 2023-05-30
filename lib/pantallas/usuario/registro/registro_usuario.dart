import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/funcionalidades/postulante.dart';
import 'package:vitium_app/pantallas/empresa/login/login_empresa.dart';
import 'package:vitium_app/pantallas/usuario/login/login_user.dart';
import 'package:vitium_app/pantallas/usuario/registro/user_registry.dart';

class RegistroUsuario extends StatefulWidget {
  const RegistroUsuario({super.key});

  @override
  State<RegistroUsuario> createState() => _RegistroUsuarioState();
}

Postulante usuario = Postulante();

class _RegistroUsuarioState extends State<RegistroUsuario> {
  late String confirmacion;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_passwordController.text == _confirmPasswordController.text) {
          await usuario.registrar().whenComplete(
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserRegistry(),
                  ),
                ),
              );
        } else {
          pushBrief(context, "Las contraseñas no coinciden");
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Fallo"),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();
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
                                Hero(
                                  tag: 'dotted1',
                                  child: DottedLine(
                                    lineLength: ancho * 0.4,
                                    dashColor: primary,
                                    direction: Axis.horizontal,
                                  ),
                                ),
                                Text(
                                  " ó ",
                                  style: TextStyle(color: primary),
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
                            child: _empresaButton(),
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
              labelText: "Correo electrónico",
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
              confirmacion = value;
            },
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  confirmacion != usuario.password) {
                return "Las contraseñas no coiciden";
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

  _empresaButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .7,
      height: MediaQuery.of(context).size.height * .06,
      child: FloatingActionButton.extended(
        heroTag: 'reclutador',
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginEmpresa(),
            ),
          );
        },
        label: Text(
          "Soy reclutador",
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
        heroTag: 'login',
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginUser(),
            ),
          );
        },
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
        heroTag: 'boton',
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

pushBrief(context, mensaje) {
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      titlePadding: const EdgeInsets.only(top: 20),
      title: Text(
        textAlign: TextAlign.center,
        "¡Ups!",
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * .04,
          color: accent,
        ),
      ),
      alignment: Alignment.center,
      content: SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width * .9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              mensaje,
              textAlign: TextAlign.center,
            ),
            Center(
              child: Image.asset(briefTriste),
            ),
          ],
        ),
      ),
      actions: [
        Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                fixedSize: Size(
                  MediaQuery.of(context).size.width * .5,
                  MediaQuery.of(context).size.height * .05,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Aceptar",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * .05,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ],
    ),
  );
}
