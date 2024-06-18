import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todolist.dart';

class TodolistController {
  // Atributo list
  List<Todolist> _list = [];
  List<Todolist> get list => _list;

  // Conectar ao Firebase Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Métodos
  // Adicionar
  Future<void> add(Todolist todolist) async {
    try {
      await _firestore.collection('todolist').add(todolist.toMap());
    } catch (e) {
      print("Erro ao adicionar tarefa: $e");
    }
  }

  // Deletar
  Future<void> delete(String id) async {
    try {
      await _firestore.collection('todolist').doc(id).delete();
      // Remove localmente
      _list.removeWhere((item) => item.id == id);
      // Notifique os ouvintes da mudança (dependendo da sua arquitetura)
      notifyListeners(); // Esta linha é apenas um exemplo
      print("Tarefa deletada com sucesso: $id");
    } catch (e) {
      print("Erro ao deletar tarefa: $e");
    }
  }

  // Atualizar
  Future<void> update(String id, Todolist todolist) async {
    try {
      await _firestore.collection('todolist').doc(id).update(todolist.toMap());
    } catch (e) {
      print("Erro ao atualizar tarefa: $e");
    }
  }

  // Buscar lista
  Future<List<Todolist>> fetchList(String userId) async {
    try {
      final QuerySnapshot result = await _firestore.collection('todolist')
          .where('userid', isEqualTo: userId)
          .get();

      _list = result.docs.map((doc) => 
        Todolist.fromMap(doc.data() as Map<String, dynamic>, doc.id, doc: doc.id)).toList();
      return _list;
    } catch (e) {
      print("Erro ao buscar lista de tarefas: $e");
      return [];
    }
  }

  // Método para notificar ouvintes (exemplo, ajuste conforme necessário)
  void notifyListeners() {
    // Implementação depende do seu framework/arquitetura
    // Por exemplo, em um StateNotifier, você chamaria state = state;
  }
}
