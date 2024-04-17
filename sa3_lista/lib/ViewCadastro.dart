import 'package:flutter/material.dart';

// Importando os arquivos necessários
import 'DataBaseController.dart';
import 'UserModel.dart';

// Tela de cadastro que é um StatelessWidget
class CadastroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'), // Título da barra superior
      ),
      body: Center(
        child: CadastroForm(), // Widget do formulário de cadastro
      ),
    );
  }
}

// Formulário de cadastro que é um StatefulWidget
class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() =>
      _CadastroFormState(); // Cria uma instância do estado do formulário de cadastro
}

// Estado do formulário de cadastro
class _CadastroFormState extends State<CadastroForm> {
  final _formKey =
      GlobalKey<FormState>(); // Chave global para identificar o formulário
  TextEditingController _emailController =
      TextEditingController(); // Controlador para o campo de email
  TextEditingController _senhaController =
      TextEditingController(); // Controlador para o campo de senha

  // Método para cadastrar o usuário
  void cadastrarUsuario(BuildContext context) async {
    String email = _emailController.text; // Obtém o email inserido
    String password = _senhaController.text; // Obtém a senha inserida

    User user = User(
        email: email,
        senha: password); // Cria um objeto User com os dados inseridos

    BancoDadosCrud bancoDados =
        BancoDadosCrud(); // Instancia a classe para controle do banco de dados
    try {
      bancoDados.create(
          user); // Chama o método para criar o usuário no banco de dados
      ScaffoldMessenger.of(context).showSnackBar(
        // Exibe uma mensagem indicando que o usuário foi cadastrado com sucesso
        SnackBar(content: Text('Usuário cadastrado com sucesso!')),
      );
      Navigator.pop(
          context); // Fecha a tela de cadastro e retorna para a tela de login
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        // Exibe uma mensagem de erro caso ocorra uma exceção ao cadastrar o usuário
        SnackBar(content: Text('Erro ao cadastrar usuário: $e')),
      );
    }
  }

  // Método de construção do widget
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey, // Associando a chave global ao formulário
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cadastro', // Título do formulário de cadastro
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller:
                  _emailController, // Associando o controlador ao campo de email
              decoration: InputDecoration(
                  labelText: 'E-mail'), // Configuração do campo de email
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira seu e-mail'; // Validando se o campo de email está vazio
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value!)) {
                  return 'E-mail inválido'; // Validando se o formato do email é válido
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller:
                  _senhaController, // Associando o controlador ao campo de senha
              decoration: InputDecoration(
                  labelText: 'Senha'), // Configuração do campo de senha
              obscureText: true, // Ocultando o texto da senha
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira sua senha'; // Validando se o campo de senha está vazio
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Validando o formulário antes de cadastrar o usuário
                  cadastrarUsuario(
                      context); // Chamando o método para cadastrar o usuário
                }
              },
              child: Text('Cadastrar'), // Texto do botão de cadastro
            ),
          ],
        ),
      ),
    );
  }
}
