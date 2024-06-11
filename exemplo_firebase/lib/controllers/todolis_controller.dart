import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todolist.dart';

class TodolistController{
  //atributo list
  List<Todolist> _list = [];
  List<Todolist> get list => _list;

  //conectar ao firebase FireStore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //métodos
  //add
  Future<void> add(Todolist todolist) async{
    await _firestore.collection('todolist').add(todolist.toMap());
  }
  //deletar
  Future<void> delete(String id) async{
    await _firestore.collection('todolist').doc(id).delete();
  }
  //fetch list
  Future<List<Todolist>> fetchList(String userId) async{
    final result = await _firestore.collection(
      'todolist')
      .where(
        'userId',
         isEqualTo: userId)
         .get();
    _list = result.docs.map((doc) => Todolist.fromMap(doc.data())).toList();
    return _list;    
  }


}