import 'package:flutter/material.dart';

class Splahs extends StatefulWidget {
  const Splahs({super.key});

  @override
  State<Splahs> createState() => _SplahsState();
}

class _SplahsState extends State<Splahs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: 0.4,
              child: Image.network(
                  "https://i.postimg.cc/vB0ZCv0X/Logo-Circular-Splahs.png"),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "Vitium, conectando con las oportunidades",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: MediaQuery.of(context).size.shortestSide * 0.05,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
