import 'package:flutter/material.dart';

import 'screen/cadastrar_produto_screen.dart';
import 'screen/home_screen.dart';
import 'screen/listar_produtos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto APIRest JSON',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/listar':(context) => const ListarProdutosScreen(),
        '/cadastrar':(context) => const CadastrarProdutoScreen()
      },
    );
  }
}