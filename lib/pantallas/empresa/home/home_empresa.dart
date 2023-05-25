import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vitium_app/constantes/constantes.dart';
import 'package:vitium_app/pantallas/usuario/detallesVacante/detalles_vacante.dart';
import 'package:vitium_app/pantallas/usuario/home/home_user.dart';
import 'package:vitium_app/pantallas/usuario/home/trabajos_screen.dart';

class HomeEnterprise extends StatefulWidget {
  const HomeEnterprise({super.key});

  @override
  State<HomeEnterprise> createState() => _HomeEnterpriseState();
}

class _HomeEnterpriseState extends State<HomeEnterprise> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    Size tam = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: tam.height,
                  width: tam.width * 0.25,
                  color: accent,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Crea",
                              style: TextStyle(fontSize: tam.width * 0.08),
                            ),
                            Image.asset(logoVitium, width: tam.width * 0.15),
                          ],
                        ),
                        Text(
                          "oportunidades",
                          style: TextStyle(
                              fontSize: tam.width * 0.07, color: primary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 100,
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: tam.width * 0.9,
                    height: tam.height * 0.15,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: tam.height * 0.15,
                          width: tam.width * 0.85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.work_outline,
                                  color: tertiary, size: tam.height * 0.07),
                              Text(
                                "Puestos publicados",
                                style: TextStyle(
                                    color: primary,
                                    fontSize: tam.height * 0.025),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: tam.width * .83,
                            ),
                            Center(
                              child: Container(
                                height: tam.height * 0.035,
                                width: tam.width * 0.07,
                                decoration: BoxDecoration(
                                  color: tertiary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: background),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 100,
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: tam.width * 0.9,
                    height: tam.height * 0.15,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: tam.height * 0.15,
                          width: tam.width * 0.85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.compare_arrows_rounded,
                                  color: tertiary, size: tam.height * 0.07),
                              Text(
                                "Perfil empresa",
                                style: TextStyle(
                                    color: primary,
                                    fontSize: tam.height * 0.025),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: tam.width * .83,
                            ),
                            Center(
                              child: Container(
                                height: tam.height * 0.035,
                                width: tam.width * 0.07,
                                decoration: BoxDecoration(
                                  color: tertiary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: background),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 100,
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: tam.width * 0.9,
                    height: tam.height * 0.15,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: tam.height * 0.15,
                          width: tam.width * 0.85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.supervisor_account_sharp,
                                  color: tertiary, size: tam.height * 0.07),
                              Text(
                                "Ver postulantes",
                                style: TextStyle(
                                    color: primary,
                                    fontSize: tam.height * 0.025),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: tam.width * .83,
                            ),
                            Center(
                              child: Container(
                                height: tam.height * 0.035,
                                width: tam.width * 0.07,
                                decoration: BoxDecoration(
                                  color: tertiary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: background),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 100,
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: tam.width * 0.9,
                    height: tam.height * 0.15,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: tam.height * 0.15,
                          width: tam.width * 0.85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.edit_note_sharp,
                                  color: tertiary, size: tam.height * 0.07),
                              Text(
                                "Publicar empleo",
                                style: TextStyle(
                                    color: primary,
                                    fontSize: tam.height * 0.025),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: tam.width * .83,
                            ),
                            Center(
                              child: Container(
                                height: tam.height * 0.035,
                                width: tam.width * 0.07,
                                decoration: BoxDecoration(
                                  color: tertiary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: background),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: tam.height * .1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
