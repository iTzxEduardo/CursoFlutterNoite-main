// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart'; // Importa o pacote Flutter para utilizar os widgets e funcionalidades do Material Design
import 'View/LoginPageView.dart'; // Importa o arquivo LoginPageView.dart, que contém a definição da tela de login

void main() {
  runApp(MyApp()); // Inicia a execução do aplicativo, passando uma instância de MyApp para runApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Construtor da classe MyApp, que herda de StatelessWidget

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Retorna um MaterialApp, que configura aspectos visuais e comportamentais do aplicativo
      title: "SA3", // Define o título do aplicativo
      debugShowCheckedModeBanner: false, // Oculta o banner de debug no canto superior direito da tela
      home: PaginaLogin(), // Define a tela inicial do aplicativo como a classe PaginaLogin
    );
  }
}
