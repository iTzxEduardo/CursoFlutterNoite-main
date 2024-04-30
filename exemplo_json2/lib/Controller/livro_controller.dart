import 'dart:convert';

import 'package:exemplo_json2/Model/livros_model.dart';
import 'package:flutter/services.dart';

class LivroController {
    List<Livro> livros = [];
    Future<List<Livro>> loadLivros() async {
      final data = await rootBundle.loadString("assets/livro.json");
      final listLivros = json.decode(data) as List<dynamic>;
      livros.clear(); 
      livros.addAll(listLivros.map((e) => Livro.fromJson(e)));
      return livros;
    }
}