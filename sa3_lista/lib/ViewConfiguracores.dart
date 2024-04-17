import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesPage extends StatefulWidget {
  final String email;

  ConfiguracoesPage({required this.email});

  @override
  _ConfiguracoesPageState createState() => _ConfiguracoesPageState(email: email);
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late SharedPreferences _prefs;
  final String email;
  TextEditingController _tarefaController = TextEditingController();
  List<String> _tarefas = [];
  List<bool> _tarefasConcluidas = [];

  _ConfiguracoesPageState({required this.email});

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    List<String>? tarefas = _prefs.getStringList('tarefas');
    List<String>? tarefasConcluidas = _prefs.getStringList('tarefasConcluidas');

    if (tarefas != null && tarefasConcluidas != null) {
      setState(() {
        _tarefas = tarefas;
        _tarefasConcluidas = tarefasConcluidas.map((value) => value == '1').toList();
      });
    }
  }

  Future<void> _salvarTarefas() async {
    List<String> tarefasAsString = _tarefas.map((tarefa) => tarefa.toString()).toList();
    List<String> tarefasConcluidasAsString = _tarefasConcluidas.map((concluida) => concluida ? '1' : '0').toList();

    await _prefs.setStringList('tarefas', tarefasAsString);
    await _prefs.setStringList('tarefasConcluidas', tarefasConcluidasAsString);
  }

  void _adicionarTarefa(String novaTarefa) {
    print('Tarefa adicionada: $novaTarefa');
    setState(() {
      _tarefas.add(novaTarefa);
      _tarefasConcluidas.add(false);
    });
    _tarefaController.clear();
    _salvarTarefas();
  }

  void _marcarComoConcluida(int index) {
    setState(() {
      _tarefasConcluidas[index] = !_tarefasConcluidas[index];
    });
    _salvarTarefas();
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
            TextField(
              controller: _tarefaController,
              decoration: InputDecoration(labelText: 'Nova Tarefa'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _adicionarTarefa(_tarefaController.text);
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
                  return ListTile(
                    title: Text(
                      _tarefas[index],
                      style: _tarefasConcluidas[index] ? TextStyle(decoration: TextDecoration.lineThrough) : null,
                    ),
                    trailing: Checkbox(
                      value: _tarefasConcluidas[index],
                      onChanged: (value) {
                        _marcarComoConcluida(index);
                      },
                      activeColor: Colors.green,
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
