import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:projeto_apirest/Model/produtos_model.dart';

class ProdutosController{
  List<Produtos> _produtos = [];

  List<Produtos> get produtos{
    return _produtos;
  }

  final String url = "http://10.109.204.15/produtos/";

  Future<List<Produtos>> getProdutos() async{
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      List<Map<String,dynamic>> produtos = json.decode(response.body);
      _produtos = produtos.map((prod) => Produtos.fromJson(prod)).toList();
      return _produtos;
    }
    return [];
  }

  
}