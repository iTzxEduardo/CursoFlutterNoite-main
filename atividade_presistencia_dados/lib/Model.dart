class ContaModel {

  int id;
  String nome;
  String email;
  


ContaModel({
  required this.id,
 required this.nome,
 required this.email,
});

Map<String, dynamic> toMap(){
  return{
    'id': id,
    'nome': nome,
    'email': email,

  };
}

factory ContaModel.fromMap(Map<String, dynamic> map){
  return ContaModel(
    id: map['id'],
    nome: map['nome'],
    email: map['email'],
    );
}

}