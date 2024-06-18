import 'package:flutter/material.dart';
import 'package:exemplo_firebase/controllers/todolis_controller.dart';
import 'package:exemplo_firebase/services/auth_service.dart';
import 'package:exemplo_firebase/models/todolist.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TodolistScreen extends StatefulWidget {
  final User user;

  const TodolistScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<TodolistScreen> createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  final AuthServices _service = AuthServices();
  final TodolistController _controller = TodolistController();
  final TextEditingController _tituloController = TextEditingController();
  late Future<void> _getListFuture;

  @override
  void initState() {
    super.initState();
    _getListFuture = _getList();
  }

  Future<void> _getList() async {
    try {
      await _controller.fetchList(widget.user.uid);
    } catch (e) {
      print("Erro ao buscar lista: $e");
    }
  }

  Future<void> _refreshList() async {
    await _getList();
    setState(() {}); // Atualiza a UI após buscar a lista
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _service.logoutUsuario();
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder<void>(
          future: _getListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar a lista'));
            } else {
              return _controller.list.isEmpty
                  ? Center(child: Text('Nenhuma tarefa encontrada'))
                  : ListView.builder(
                      itemCount: _controller.list.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_controller.list[index].titulo),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              await _controller.delete(_controller.list[index].id!);
                              _refreshList();
                            },
                          ),
                        );
                      },
                    );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Nova Tarefa"),
                content: TextFormField(
                  controller: _tituloController,
                  decoration: const InputDecoration(hintText: "Digite a tarefa"),
                ),
                actions: [
                  TextButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text("Salvar"),
                    onPressed: () async {
                      Navigator.of(context).pop();

                      // Verifica se já existe uma tarefa com o mesmo título
                      bool hasDuplicate = _controller.list.any((task) =>
                          task.titulo.toLowerCase() == _tituloController.text.toLowerCase());

                      if (hasDuplicate) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Erro"),
                              content: Text("Já existe uma tarefa com o mesmo nome."),
                              actions: [
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Todolist add = Todolist(
                          id: (_controller.list.length + 1).toString(),
                          titulo: _tituloController.text,
                          userId: widget.user.uid,
                          timeStamp: DateTime.now(),
                        );
                        await _controller.add(add);
                        _tituloController.clear();
                        _refreshList();
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
