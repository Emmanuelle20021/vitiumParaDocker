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
          children: [
            Image.network(
                "https://drive.google.com/file/d/1MbktlIDWsOQpxSepG-DxGJOyUlWcRH4X/view?usp=sharing"),
          ],
        ),
      ),
    );
  }
}
