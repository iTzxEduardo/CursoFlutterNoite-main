// ignore_for_file: file_names
import 'dart:convert'; // Importa o pacote 'dart:convert' para utilizar funções de codificação e decodificação JSON
import 'package:flutter/material.dart'; // Importa o pacote Flutter para utilizar os widgets do Material Design
import 'package:shared_preferences/shared_preferences.dart'; // Importa o pacote para acessar as preferências compartilhadas

class Task {
  String title; // Título da tarefa
  String status; // Status da tarefa

  Task({required this.title, required this.status}); // Construtor da classe Task

  // Método para serializar uma tarefa em um mapa
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'status': status,
    };
  }

  // Método para criar uma tarefa a partir de um mapa
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      status: map['status'],
    );
  }
}

class PaginaHome extends StatefulWidget {
  String email; // E-mail do usuário
  PaginaHome({required this.email}); // Construtor da classe PaginaHome

  @override
  State<PaginaHome> createState() => _PaginaHomeState(email: email); // Cria e retorna o estado da página home
}

class _PaginaHomeState extends State<PaginaHome> {
  late SharedPreferences _prefs; // Preferências compartilhadas para armazenar as tarefas
  String email; // E-mail do usuário
  List<Task> _tasks = []; // Lista de tarefas
  TextEditingController _taskController = TextEditingController(); // Controlador do campo de nova tarefa
  String _selectedStatus = 'Todos'; // Status selecionado para filtrar as tarefas

  _PaginaHomeState({required this.email}); // Construtor da classe _PaginaHomeState

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Carrega as preferências compartilhadas ao iniciar a tela
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance(); // Obtém as preferências compartilhadas
    _loadTasksFromPrefs(); // Carrega as tarefas salvas
  }

  void _loadTasksFromPrefs() {
    List<String>? tasksJson = _prefs.getStringList('${email}_tasks'); // Obtém a lista de tarefas em formato JSON
    if (tasksJson != null) {
      setState(() {
        _tasks = tasksJson
            .map((json) =>
                Task.fromMap(Map<String, dynamic>.from(jsonDecode(json))))
            .toList(); // Converte os dados JSON de volta para objetos Task
      });
    }
  }

  void _saveTasksToPrefs() {
    List<String> tasksJson =
        _tasks.map((task) => jsonEncode(task.toMap())).toList(); // Converte as tarefas para JSON
    _prefs.setStringList('${email}_tasks', tasksJson); // Salva as tarefas nas preferências compartilhadas
  }

  void _addTask(String title) {
    setState(() {
      _tasks.add(Task(title: title, status: 'Em andamento')); // Adiciona uma nova tarefa à lista
      _saveTasksToPrefs(); // Salva as tarefas após adicionar uma nova
    });
    _taskController.clear(); // Limpa o campo de nova tarefa após adicionar
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index); // Remove a tarefa na posição especificada
      _saveTasksToPrefs(); // Salva as tarefas após excluir uma
    });
  }

  void _updateTaskStatus(int index, String status) {
    setState(() {
      _tasks[index].status = status; // Atualiza o status da tarefa na posição especificada
      _saveTasksToPrefs(); // Salva as tarefas após atualizar o status
    });
  }

  List<Task> _filteredTasks() {
    if (_selectedStatus == 'Todos') {
      return _tasks; // Retorna todas as tarefas se o status selecionado for 'Todos'
    } else {
      return _tasks.where((task) => task.status == _selectedStatus).toList(); // Filtra as tarefas pelo status selecionado
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'), // Título da barra de aplicativo
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                hintText: 'Nova Tarefa',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_taskController.text.trim().isNotEmpty) {
                      _addTask(_taskController.text.trim()); // Adiciona uma nova tarefa ao pressionar o botão de adicionar
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedStatus,
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!; // Atualiza o status selecionado ao alterar a opção no dropdown
                });
              },
              items:
                  <String>['Todos', 'Em andamento', 'Concluída', 'Finalizada']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(), // Define as opções do dropdown com base nos status possíveis
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredTasks().length,
                itemBuilder: (context, index) {
                  final task = _filteredTasks()[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.status),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Concluída'),
                          value: 'Concluída',
                        ),
                        PopupMenuItem(
                          child: Text('Em andamento'),
                          value: 'Em andamento',
                        ),
                        PopupMenuItem(
                          child: Text('Finalizada'),
                          value: 'Finalizada',
                        ),
                        PopupMenuItem(
                          child: Text('Apagar'),
                          value: 'Apagar',
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 'Apagar') {
                          _deleteTask(index); // Exclui a tarefa ao selecionar a opção 'Apagar' no menu popup
                        } else {
                          _updateTaskStatus(index, value.toString()); // Atualiza o status da tarefa
                        }
                      },
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
