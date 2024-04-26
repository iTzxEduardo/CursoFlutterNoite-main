import 'dart:convert';
import 'dart:io';

import 'package:projeto_json/Model/produtos_model.dart';

class ProdutoController{
  List<Produto> _produtos = [];

  List<Produto> get produtos{
    return _produtos;
  }

  //salvar produtos no json
  Future<void> salvarJson() async {
    final file = File('produtos.json');
    final jsonList = produtos.map((produto) => produto.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));

  }

  //carregar produtos do json 

  Future<void> carregarJson()async {
    try {
      final file = File('produtos.json');
      final jsonList = jsonDecode(await file.readAsString());
      _produtos = jsonList.map<Produto>((json) => Produto.fromJson(json)).toList();
    } catch (e) {
     _produtos = [];
    }
  }
  
}