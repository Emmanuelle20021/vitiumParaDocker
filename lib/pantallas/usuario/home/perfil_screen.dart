import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Trabajo de Rossy',
        style: TextStyle(fontSize: 60),
      ),
    );
  }
}
