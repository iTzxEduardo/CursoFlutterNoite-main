class Produtos{
  final int id;
  final String nome;
  final String codigo;

  Produtos({required this.id, required this.nome, required this.codigo});
  //metodos
  //toJson
  List<Map<String,dynamic>> toJson(){
    return [
      {
        'id': id,
        'nome': nome,
        'codigo': codigo
      }
    ];
  }
  //fromJsom
  factory Produtos.fromJson(Map<String,dynamic> json){ 
    return Produtos(
      id: json['id'],
      nome: json['nome'],
      codigo: json['codigo']
    );
  }

}