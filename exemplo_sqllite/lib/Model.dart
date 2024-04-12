class ContatoModel {

  //atributos
  int id;
  String nome;
  String email;



//constutot
  ContatoModel({
 required this.id,
 required this.nome,
 required this.email,

  });

  //mapeamentos
    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
     
    };
  }
    factory ContatoModel.fromMap(Map<String, dynamic> map) {
    return ContatoModel(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
    
    );
  }
}