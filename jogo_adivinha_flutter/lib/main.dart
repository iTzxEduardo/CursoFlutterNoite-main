import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  //atributos
  TextEditingController _controllerNumero1 = TextEditingController();
  String _resultado = '';
  int numeroSorteado = Random().nextInt(100) + 1;
  int cont = 0;
  bool acertou = false;

  //método
  void _adivinhar() {
    int? numero = int.tryParse(_controllerNumero1.text) as int;

    setState(() {
      if (numero == numeroSorteado) {
        _resultado = "Parabens Você Acertou!!! Em $cont Tentativas!";
        acertou = true;
      } else if (numero < numeroSorteado) {
        _resultado = "Tente um Nº Maior";
        cont++;
      } else if (numero > numeroSorteado) {
        _resultado = "Tente um Nº MEnor";
        cont++;
      } else {
        _resultado = "Operação Incorreta !!";
      }
    });
  }

  void _reiniciar() {
    setState(() {
      numeroSorteado = Random().nextInt(100) + 1;
      cont = 0;
      _resultado = "";
      acertou = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Adivinhação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllerNumero1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Digite um Nº'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () => _adivinhar(),
              child: Text('Adivinhar'),
            ),
            SizedBox(height: 16.0),
            Text(_resultado,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Visibility(
              visible: acertou,
              child: ElevatedButton(
                onPressed: () => _reiniciar(),
                child: Text('Reiniciar Jogo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
