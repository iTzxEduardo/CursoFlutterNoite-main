class Livro {
  //atributos
  final String titulo;
  final String autor;
  final String sinopse;
  final String categoria;
  final int isbn;

  //construtor
  Livro(
      {required this.titulo,
      required this.autor,
      required this.sinopse,
      required this.categoria,
      required this.isbn});

  //metodos
  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'autor': autor,
      'sinopse': sinopse,
      'categoria': categoria,
      'isbn': isbn,
    };
  }

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      titulo: json['titulo'],
      autor: json['autor'],
      sinopse: json['sinopse'],
      categoria: json['categoria'],
      isbn: json['isbn'],
    );
  }
}
