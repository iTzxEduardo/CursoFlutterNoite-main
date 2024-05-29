import 'package:flutter/material.dart';
import 'package:projeto_apirest/View/home_screen.dart';

import 'View/produtos_lista_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        '/lista': (context) => ListaScreen()
      },
    );
  }
}
