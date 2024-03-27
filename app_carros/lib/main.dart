import 'package:app_carros/Controller.dart';
import 'package:app_carros/View.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CarroController controllerCarro = CarroController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Carros',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaListaCarros(controllerCarro),
    );
  }
}
