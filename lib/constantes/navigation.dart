import 'package:flutter/material.dart';

void main() => runApp(const Navegation());

class Navegation extends StatelessWidget {
  const Navegation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedIconTheme: IconThemeData(color: Colors.deepPurpleAccent),
          unselectedIconTheme: IconThemeData(color: Colors.yellow),
        ),
      ),
      home: const Barra(),
    );
  }
}

class Barra extends StatefulWidget {
  const Barra({super.key});

  @override
  State<Barra> createState() => _BarraState();
}

class _BarraState extends State<Barra> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[menu, trabajo, perfil],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

var perfil = BottomNavigationBarItem(
  icon: Icon(Icons.person_2_outlined),
  activeIcon: Icon(Icons.person),
  label: 'Perfil',
);
var trabajo = BottomNavigationBarItem(
  icon: Icon(Icons.work_outline),
  activeIcon: Icon(Icons.work),
  label: 'Trabajos',
);

var menu = BottomNavigationBarItem(
  icon: Icon(Icons.home_outlined),
  activeIcon: Icon(Icons.home_filled),
  label: 'Home',
);
