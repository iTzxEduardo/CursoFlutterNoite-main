import 'Model.dart'; // Importa o modelo de dados ContatoModel
import 'package:path/path.dart'; // Importa utilitários para manipulação de caminhos de arquivos
import 'package:sqflite/sqflite.dart'; 

class BancoDadosCrud {
  static const String DB_NOME = 'conta.db'; // Nome do banco de dados
  static const String TABLE_NOME = 'conta'; // Nome da tabela
  static const String
      CREATE_CONTACTS_TABLE_SCRIPT = // Script SQL para criar a tabela de contatos
      "CREATE TABLE IF NOT EXISTS contacts(id INTEGER PRIMARY KEY," +
          "nome TEXT, email TEXT, telefone TEXT," +
          "endereco TEXT)";

  // Método para obter uma instância do banco de dados
  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME), // Caminho do banco de dados
      onCreate: (db, version) {
        return db.execute(
            CREATE_CONTACTS_TABLE_SCRIPT); // Executa o script de criação da tabela quando o banco é criado
      },
      version: 1, // Versão do banco de dados
    );
  }

  // Método para criar um novo contato no banco de dados
  Future<void> create(ContaModel model) async {
    try {
      final Database db = await _getDatabase(); // Obtém uma instância do banco de dados
      await db.insert(
          TABLE_NOME, model.toMap()); // Insere o contato na tabela de contatos
    } catch (ex) {
      print(ex); // Imprime qualquer exceção ocorrida
      return;
    }
  }

  // Método para obter todos os contatos do banco de dados
  Future<List<ContaModel>> getContacts() async {
    try {
      final Database db = await _getDatabase(); // Obtém uma instância do banco de dados
      final List<Map<String, dynamic>> maps =
          await db.query(TABLE_NOME); // Consulta todos os contatos na tabela

      return List.generate(
        maps.length,
        (i) {
          return ContaModel.fromMap(maps[
              i]); // Converte os resultados da consulta para objetos ContactModel
        },
      );
    } catch (ex) {
      print(ex); // Imprime qualquer exceção ocorrida
      return [];
    }
  }

  // Método para atualizar um contato no banco de dados
  Future<void> update(ContaModel model) async {
    try {
      final Database db = await _getDatabase(); // Obtém uma instância do banco de dados
      await db.update(
        TABLE_NOME,
        model.toMap(),
        where: "id = ?", // Condição para atualizar o contato com base no ID
        whereArgs: [model.id],
      );
    } catch (ex) {
      print(ex); // Imprime qualquer exceção ocorrida
      return;
    }
  }

  // Método para excluir um contato do banco de dados
  Future<void> delete(int id) async {
    try {
      final Database db = await _getDatabase(); // Obtém uma instância do banco de dados
      await db.delete(
        TABLE_NOME,
        where: "id = ?", // Condição para excluir o contato com base no ID
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex); // Imprime qualquer exceção ocorrida
      return;
    }
  }
}


  // Future<dynamic> openDatabase(String join, {required Function(dynamic db, dynamic version) onCreate, required int version}) {}
//  Future<bool> acessoInterno( user, name)async{
//   bool x =  false;
//   final Databese db = await _getDatabase();
//   var retorno = db.rawQuery('Select * FROM where user = 'user' and senha = 'senha' ');
//   if(retorno>0){
//     x-true;
//   }
// return x
//  }
