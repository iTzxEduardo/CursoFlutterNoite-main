import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Classe para a tela de cadastro
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

// Classe para o formulário de cadastro
class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _formKey = GlobalKey<FormState>(); // Chave global para identificar o formulário
  TextEditingController _emailController = TextEditingController(); // Controlador para o campo de email
  TextEditingController _senhaController = TextEditingController(); // Controlador para o campo de senha

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
                'Cadastro', // Título do formulário
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
              ElevatedButton( // Botão de cadastro
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Realize a lógica de cadastro aqui
                    // Por exemplo, chame uma função para salvar os dados no banco de dados
                    // Depois, você pode navegar para outra tela ou fazer outra ação, se necessário
                  }
                },
                child: Text('Cadastrar'),
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
