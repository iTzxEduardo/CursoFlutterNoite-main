import 'package:app_todolist/TarefasController.dart';
import 'package:app_todolist/TarefasView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TarefasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Definindo a tela inicial como a TarefasScreen e utilizando o Provider
      home: ChangeNotifierProvider(
        create: (context) => TarefasController(),
        child: TarefasScreen(),
      ),
    );
  }
}