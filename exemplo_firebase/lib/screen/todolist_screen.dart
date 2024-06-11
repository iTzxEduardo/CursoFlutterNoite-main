import 'package:exemplo_firebase/controllers/todolist_controller.dart';
import 'package:exemplo_firebase/models/todolist.dart';
import 'package:exemplo_firebase/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodolistScreen extends StatefulWidget {
  final User user;
  const TodolistScreen({super.key, required this.user});

  @override
  State<TodolistScreen> createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  final AuthService _service =AuthService();
  final TodolistController _controller =TodolistController();
  final _tituloController = TextEditingController();

  Future<void> _getList() async{
    try {
      await _controller.fetchList(widget.user.uid);
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List Firebase'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              //chamar o logout
              await _service.logoutUsuario();
              Navigator.pushReplacementNamed(context, '/home');
            })]
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Expanded(
            child: FutureBuilder(
              future: _getList(), 
              builder: (context,snapshot){
                if(_controller.list.isNotEmpty){
                  return ListView.builder(
                    itemCount: _controller.list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_controller.list[index].titulo),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await _controller.delete(_controller.list[index].id);
                            _getList();
                          },
                        ),
                      );
                    },
                  );
                }else if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context, 
            builder: (context){
              return AlertDialog(
                title: Text("Nova Tarefa"),
                content: TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(hintText: "Digite a tarefa"),
                ),
                actions: [
                  TextButton(
                    child: Text("Cancelar"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text("Salvar"),
                    onPressed: (){
                      Navigator.of(context).pop();
                      Todolist add = Todolist(
                        id:(_controller.list.length+1).toString(),
                        titulo: _tituloController.text,
                        userId: widget.user.uid,
                        timestamp: DateTime.now()
                      );
                      _controller.add(add);
                      _getList();
                    })]);
            });
        })
    );
  }
}