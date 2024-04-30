import 'package:exemplo_json2/Model/livros_model.dart';
import 'package:flutter/material.dart';

class LivroInfoPage extends StatelessWidget {
  Livro info;
  LivroInfoPage({required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livro Info'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(info.titulo),
            Text(info.autor),
            Text(info.categoria),
            Text("${info.isbn}"),
          ],
        )
      ),
    );
  }
}