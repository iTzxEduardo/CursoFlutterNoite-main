import 'package:atividade_presistencia_dados/Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = BancoDadosCrud();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _idController =
      TextEditingController(); // Controlador para o campo de ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login ou Cadastro'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildEmailTextField(),
                SizedBox(height: 20),
                _buildPasswordTextField(),
                SizedBox(height: 20),
                SizedBox(height: 30),
                _buildLoginButton(context),
                SizedBox(height: 10),
                _buildSignUpButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      obscureText: true,
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Senha',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      child: Text('Entrar'),
      onPressed: () {
        // Adicione sua lógica de login aqui
      },
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return TextButton(
      child: Text('Cadastre-se'),
      onPressed: () => _navigateToCadastroPage(context),
    );
  }

  void _navigateToCadastroPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Página de Cadastro"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(labelText: 'Nome'),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Senha'),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller:
                        _idController, // Usando o controlador para o campo de ID
                    decoration: const InputDecoration(labelText: 'ID'),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Aqui você adicionará a lógica para criar a conta
                    },
                    child: const Text('Cadastrar'),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
