import 'package:app_todolist/TarefasModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TarefasController extends ChangeNotifier {
  // Lista de tarefas
  List<Tarefas> _tarefas = [];
  // Getter para acessar a lista de tarefas
  List<Tarefas> get tarefas => _tarefas;

  // Método para adicionar uma nova tarefa à lista
  void adicionarTarefa(String descricao) {
    if (descricao.trim().isNotEmpty) {
      _tarefas.add(Tarefas(descricao, false, getData() as DateTime));
      // Notifica os ouvintes (widgets) sobre a mudança no estado
      notifyListeners();
    }
  }

  // Método para marcar uma tarefa como concluída com base no índice
  void marcarComoConcluida(int indice) {
    if (indice >= 0 && indice < _tarefas.length) {
      _tarefas[indice].concluida = true;
      // Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

  void marcarComoNaoConcluida(int indice) {
    if (indice >= 0 && indice < _tarefas.length) {
      _tarefas[indice].concluida = false;
      // Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

  // Método para excluir uma tarefa com base no índice
  void excluirTarefa(int indice) {
    if (indice >= 0 && indice < _tarefas.length) {
      _tarefas.removeAt(indice);
      // Notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

  String getData() {
    return DateFormat('dd/MM/yyyy HH:mm').format(_tarefas.last.dataHora);
  }
}
