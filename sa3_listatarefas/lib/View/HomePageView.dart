import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesPage extends StatefulWidget {
  final String email;

  ConfiguracoesPage({required this.email});

  @override
  _ConfiguracoesPageState createState() => _ConfiguracoesPageState(email: email);
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late SharedPreferences _prefs; // Instância para acessar as preferências compartilhadas
  final String email; // Armazena o email passado ao widget
  TextEditingController _tarefaController = TextEditingController(); // Controlador para o campo de texto
  List<String> _tarefas = []; // Lista de tarefas
  List<bool> _tarefasConcluidas = []; // Lista de booleanos indicando se a tarefa foi concluída

  _ConfiguracoesPageState({required this.email}); // Construtor

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Carrega as preferências ao iniciar o widget
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance(); // Obtém a instância das preferências compartilhadas
    List<String>? tarefas = _prefs.getStringList('tarefas_$email'); // Obtém as tarefas salvas
    List<String>? tarefasConcluidas = _prefs.getStringList('tarefasConcluidas_$email'); // Obtém as tarefas concluídas

    if (tarefas != null && tarefasConcluidas != null) {
      setState(() {
        _tarefas = tarefas; // Atualiza a lista de tarefas
        _tarefasConcluidas = tarefasConcluidas.map((value) => value == '1').toList(); // Atualiza a lista de tarefas concluídas
      });
    }
  }

  Future<void> _salvarTarefas() async {
    List<String> tarefasAsString = _tarefas.map((tarefa) => tarefa.toString()).toList(); // Converte as tarefas para strings
    List<String> tarefasConcluidasAsString = _tarefasConcluidas.map((concluida) => concluida ? '1' : '0').toList(); // Converte as tarefas concluídas para strings

    await _prefs.setStringList('tarefas_$email', tarefasAsString); // Salva as tarefas
    await _prefs.setStringList('tarefasConcluidas_$email', tarefasConcluidasAsString); // Salva as tarefas concluídas
  }

  void _adicionarTarefa(String novaTarefa) {
    // Verifica se o campo de texto está vazio
    if (novaTarefa.isNotEmpty) {
      print('Tarefa adicionada: $novaTarefa'); // Exibe a nova tarefa no console
      setState(() {
        _tarefas.add(novaTarefa); // Adiciona a nova tarefa à lista de tarefas
        _tarefasConcluidas.add(false); // Adiciona "false" à lista de tarefas concluídas, indicando que a nova tarefa não foi concluída
      });
      _tarefaController.clear(); // Limpa o campo de texto
      _salvarTarefas(); // Salva as tarefas
    } else {
      // Mostra uma mensagem de erro ou alerta ao usuário
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erro"),
            content: Text("Por favor, insira uma tarefa válida."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  void _marcarComoConcluida(int index) {
    setState(() {
      _tarefasConcluidas[index] = !_tarefasConcluidas[index]; // Alterna o estado da tarefa (concluída/não concluída)
    });
    _salvarTarefas(); // Salva as tarefas
  }

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index); // Remove a tarefa da lista
      _tarefasConcluidas.removeAt(index); // Remove o estado correspondente da lista de tarefas concluídas
    });
    _salvarTarefas(); // Salva as tarefas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Tarefa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), // Borda preta
                borderRadius: BorderRadius.circular(8.0), // Borda arredondada
              ),
              child: TextField(
                controller: _tarefaController,
                decoration: InputDecoration(labelText: 'Nova Tarefa'),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _adicionarTarefa(_tarefaController.text); // Adiciona a tarefa quando o botão é pressionado
              },
              child: Text('Adicionar Tarefa'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Tarefas Adicionadas:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // Borda preta
                      borderRadius: BorderRadius.circular(8.0), // Borda arredondada
                    ),
                    child: ListTile(
                      title: Text(
                        _tarefas[index],
                        style: _tarefasConcluidas[index] ? TextStyle(decoration: TextDecoration.lineThrough) : null, // Adiciona uma linha através do texto se a tarefa estiver concluída
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete), // Ícone de exclusão
                            onPressed: () {
                              _removerTarefa(index); // Remove a tarefa quando o ícone é pressionado
                            },
                          ),
                          Checkbox(
                            value: _tarefasConcluidas[index], // Define o estado do checkbox com base na lista de tarefas concluídas
                            onChanged: (value) {
                              _marcarComoConcluida(index); // Marca a tarefa como concluída quando o estado do checkbox é alterado
                            },
                            activeColor: Colors.green, // Define a cor do checkbox quando está selecionado
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
