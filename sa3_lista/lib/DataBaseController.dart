import 'package:path/path.dart'; // Importa a função join para manipular caminhos de arquivo
import 'package:sa3_lista/UserModel.dart';
import 'package:sqflite/sqflite.dart'; // Importa a biblioteca Sqflite para interagir com o banco de dados

// Classe para realizar operações CRUD no banco de dados
class BancoDadosCrud {
  static const String DB_NOME = 'lista1.db'; // Nome do banco de dados
  static const String TABLE_NOME = 'lista1'; // Nome da tabela
  static const String
      SCRIPT_CRIACAO_TABELA = // Script SQL para criar a tabela
      "CREATE TABLE IF NOT EXISTS lista1(id INTEGER PRIMARY KEY," +
          "nome TEXT,"+ " email TEXT," + "senha TEXT)";

  // Método privado para obter uma instância do banco de dados
  Future<Database> _chamarBanco() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME), // Caminho do banco de dados
      onCreate: (db, version) {
        return db.execute(
            SCRIPT_CRIACAO_TABELA); // Executa o script de criação da tabela quando o banco é criado
      },
      version: 1,
    );
  }

  // Método para criar um novo usuário no banco de dados
  Future<void> create(User user) async {
    try {
      final Database db = await _chamarBanco();
      await db.insert(
          TABLE_NOME, user.toMap()); // Insere o usuário no banco de dados
    } catch (ex) {
      print(ex);
      return;
    }
  }

  // Método para obter o usuário do banco de dados usando email e senha
  Future<User?> getUser(String email, String senha) async {
    try {
      final Database db = await _chamarBanco();
      final List<Map<String, dynamic>> maps =
          await db.query(TABLE_NOME, where: 'email = ? and senha = ?', whereArgs: [email,senha]); // Consulta o usuário na tabela

      if(maps.isNotEmpty){
        return User.fromMap(maps.first); // Retorna o primeiro usuário encontrado
      } else {
        return null; // Retorna nulo se nenhum usuário for encontrado
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  // Método para verificar se um usuário existe no banco de dados usando email e senha
  Future<bool> existsUser(String email, String senha) async {
    bool acessoPermitido = false; // Define a variável de acesso como falsa inicialmente
    try {
      final Database db = await _chamarBanco();
      final List<Map<String, dynamic>> maps =
          await db.query(TABLE_NOME, where: 'email = ? AND senha = ?', whereArgs: [email,senha]); // Consulta o usuário na tabela

      if (maps.isNotEmpty) {
        acessoPermitido = true; // Define a variável de acesso como verdadeira se o usuário for encontrado
      }
      return acessoPermitido; // Retorna a variável de acesso
    } catch (ex) {
      print(ex);
      return acessoPermitido; // Retorna a variável de acesso em caso de erro
    }
  }

  // Método para realizar o login (ainda não implementado)
  realizarLogin(String email, String senha) {}
}
