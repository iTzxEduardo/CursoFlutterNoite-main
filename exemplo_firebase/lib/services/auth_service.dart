import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> loginUsuario(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Erro ao fazer login: ${e.toString()}');
      return null;
    }
  }

  Future<String?> checkIfEmailExists(String email) async {
    try {
      var methods = await _auth.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        return 'Este e-mail já está sendo usado'; // Retorna mensagem de erro se e-mail já existir
      } else {
        return null; // Retorna null se e-mail não existir
      }
    } catch (e) {
      print('Erro ao verificar e-mail: $e');
      return 'Erro ao verificar e-mail'; // Retorna mensagem de erro genérica em caso de erro
    }
  }

  Future<void> registerUsuario(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Erro ao registrar usuário: ${e.toString()}');
      throw e; // Você pode relançar a exceção ou tratar de outra forma conforme necessário
    }
  }

  Future<void> logoutUsuario() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Erro ao fazer logout: ${e.toString()}');
    }
  }

  // Adicione métodos adicionais de autenticação conforme necessário

}