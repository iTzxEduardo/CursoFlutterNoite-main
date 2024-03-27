import 'dart:async';

import 'package:app_carros/Controller.dart';
import 'package:app_carros/Model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaListaCarros extends StatelessWidget {
  final CarroController controllerCarros;
  TelaListaCarros(this.controllerCarros);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior do aplicativo
      appBar: AppBar(
        title: Text('Meus Carros'),
      ),
      // Corpo principal do aplicativo
      body: Column(
        children: [
          // Lista de Carros
          Expanded(
            child:
                //Consumer<CarroController>(
                //builder: (context, model, child) {
                //return
                ListView.builder(
              itemCount: controllerCarros.listarCarros.length,
              itemBuilder: (context, index) {
                return ListTile(
                  // Exibição do nome do carro
                  title: Text(controllerCarros.listarCarros[index].modelo),
                  // Exclui a tarefa ao manter pressionado
                  onTap: () {
                    // Chamando a outra tela
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => TelaDetalheCarro(
                                controllerCarros.listarCarros[index]))));
                  },
                );
              },
            ),
            //   },
            // ),
          ),
        ],
      ),
      //Adicionar FloatButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _adicionarCarro(context);
        },
        child: Icon(Icons.),
      ),
    );
  }
  
  void _adicionarCarro(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Use a TextEditingController to get user input
        TextEditingController nomeController = TextEditingController();
        TextEditingController urlController = TextEditingController();

        return AlertDialog(
          title: Text('Adicionar Novo Carro'),
          content: Column(
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome do Carro'),
              ),
              TextField(
                controller: urlController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Adicionar novo carro
                controllerCarros.adicionarCarro(
                  nomeController.text,
                  2023, // You can adjust the year as needed
                  urlController.text,
                );

                // Atualizar a interface
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Adicionar'),
            ),
            TextButton(
              onPressed: () {
                // Fechar o diálogo sem adicionar o carro
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}

class TelaDetalheCarro extends StatelessWidget {
  final Carro carro;
  TelaDetalheCarro(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Carro"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(carro.imagemUrl),
            SizedBox(height: 20),
            Text("Modelo: ${carro.modelo}"),
            Text("Ano: ${carro.ano}"),
          ],
        ),
      ),
    );
  }
}
