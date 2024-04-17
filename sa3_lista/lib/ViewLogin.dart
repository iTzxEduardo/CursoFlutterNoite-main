import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sa3_lista/ViewConfiguracores.dart';
import 'DataBaseController.dart';
import 'UserModel.dart';
import 'ViewCadastro.dart';

// Classe para a tela de login
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'), // Título da barra superior
      ),
      body: Center(
        child: LoginForm(), // Widget do formulário de login
      ),
    );
  }
}

// Classe para o formulário de login
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>(); // Chave global para identificar o formulário
  TextEditingController _emailController = TextEditingController(); // Controlador para o campo de email
  TextEditingController _senhaController = TextEditingController(); // Controlador para o campo de senha
  bool _loading = false; // Variável para controlar o estado de carregamento

  // Método para efetuar o login
  void _login() async {
    if (_formKey.currentState!.validate()) { // Validando o formulário
      String email = _emailController.text; // Obtendo o email inserido
      String senha = _senhaController.text; // Obtendo a senha inserida

      setState(() {
        _loading = true; // Alterando o estado de carregamento para verdadeiro
      });

      BancoDadosCrud bancoDados = BancoDadosCrud(); // Instanciando a classe para controle do banco de dados
      try {
        User? user = await bancoDados.getUser(email, senha); // Obtendo o usuário do banco de dados
        if (user != null) {
          Navigator.push( // Navegando para a tela de configurações caso o login seja bem sucedido
            context,
            MaterialPageRoute(
              builder: (context) => ConfiguracoesPage(email: user.email), // Passando o email do usuário para a próxima tela
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar( // Exibindo uma mensagem caso o login falhe
            content: Text('Email ou senha incorretos'),
          ));
        }
      } catch (e) {
        print('Erro durante o login: $e'); // Exibindo o erro no console
        ScaffoldMessenger.of(context).showSnackBar(SnackBar( // Exibindo uma mensagem de erro caso ocorra uma exceção durante o login
          content: Text('Erro durante o login. Tente novamente mais tarde.'),
        ));
      } finally {
        setState(() {
          _loading = false; // Alterando o estado de carregamento para falso após finalizar o processo de login
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey, // Associando a chave global ao formulário
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login', // Título do formulário
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController, // Associando o controlador ao campo de email
                decoration: InputDecoration(labelText: 'E-mail'), // Configuração do campo de email
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira seu e-mail'; // Validando se o campo de email está vazio
                  } else if (!isValidEmail(value)) {
                    return 'E-mail inválido'; // Validando se o formato do email é válido
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')), // Impedindo a entrada de números no campo de email
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _senhaController, // Associando o controlador ao campo de senha
                decoration: InputDecoration(labelText: 'Senha'), // Configuração do campo de senha
                obscureText: true, // Ocultando o texto da senha
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Por favor, insira sua senha'; // Validando se o campo de senha está vazio
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _loading // Verificando o estado de carregamento para decidir se exibe o botão de login ou o indicador de progresso
                  ? CircularProgressIndicator() // Indicador de progresso enquanto o login está sendo processado
                  : ElevatedButton( // Botão de login
                      onPressed: _login,
                      child: Text('Acessar'),
                    ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroScreen()), // Navegando para a tela de cadastro ao pressionar o botão
                  );
                },
                child: Text('Não tem uma conta? Cadastre-se'), // Texto do botão para navegar para a tela de cadastro
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para validar o formato do email
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email); // Expressão regular para validar o formato do email
  }
}
