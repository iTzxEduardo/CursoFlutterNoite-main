import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salvar arquivo localmente'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Directory? directory = await getDownloadsDirectory
            ();
            File file = File('${directory?.path}/meu_arquivo.txt');
            await file.writeAsString('Conteúdo do meu arquivo.');
            print('Arquivo salvo em: ${file.path}');
          },
          child: Text('Salvar arquivo'),
        ),
      ),
    );
  }
}
