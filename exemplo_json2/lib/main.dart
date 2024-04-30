import 'package:exemplo_json2/View/lista_livros_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Itens',
      theme: ThemeData(primarySwatch: Colors.blue,
      ),
      home: LivrosPage(),
    );
  }
}