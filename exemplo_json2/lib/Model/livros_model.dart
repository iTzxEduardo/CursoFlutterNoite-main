class Livro {
  //atributos
  final String titulo;
  final String autor;
  final String sinopse;
  final String categoria;
  final int isbn;
  final String capa;

  //construtor
  Livro(
      {required this.titulo,
      required this.autor,
      required this.sinopse,
      required this.categoria,
      required this.isbn,
      required this.capa});

  //metodos
  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'autor': autor,
      'sinopse': sinopse,
      'categoria': categoria,
      'isbn': isbn,
      'capa': capa
    };
  }

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      titulo: json['titulo'],
      autor: json['autor'],
      sinopse: json['sinopse'],
      categoria: json['categoria'],
      isbn: json['isbn'],
      capa: json['capa'],
    );
  }
}
