// Importação de pacotes necessários para o funcionamento do app.
import 'package:exemplo_sqllite/Controller.dart';
import 'package:exemplo_sqllite/Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Definição da HomePage como um StatefulWidget, o que permite que seu estado seja mutável.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Estado da HomePage, onde a lógica e a interface do usuário são definidos.
class _HomePageState extends State<HomePage> {
  final dbHelper = BancoDadosCrud(); // Instância da classe que gerencia o banco de dados.
  final _formKey = GlobalKey<FormState>(); // Chave global para o formulário, usada para validação.

  // Controladores para os campos de texto, permitindo que sejam lidos ou modificados.
  TextEditingController _idController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Construção da interface da HomePage.
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Demo'),
      ),
      // FutureBuilder para carregar e exibir os dados do banco de dados de forma assíncrona.
      body: FutureBuilder<List<ContatoModel>>(
        future: dbHelper.getContacts(), // Carrega os contatos do banco de dados.
        builder: (context, snapshot) {
          // Verifica o estado da conexão do Future.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Exibe um erro caso algo dê errado.
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Caso não haja dados, informa o usuário.
            return Center(child: Text('Nenhum Contato Cadastrado.'));
          } else {
            // Se houver dados, constrói uma lista com eles.
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final contact = snapshot.data![index];
                return ListTile(
                  title: Text(contact.nome),
                  subtitle: Text(contact.email),
                  onTap: () {
                    // Aqui poderia ser implementada uma lógica para ver detalhes do contato.
                  },
                );
              },
            );
          }
        },
      ),
      // Botão para adicionar novos contatos.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddContactDialog(context); // Mostra um diálogo para adicionar novo contato.
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Diálogo para adicionar um novo contato, utilizando um Form para validação.
  void _showAddContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Contact'),
          content: Form(
            key: _formKey, // Associa a chave global do formulário para validação.
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Campos de texto com validação para ID, nome, email, telefone e endereço.
                 // Campos aqui.
              ],
            ),
          ),
          actions: <Widget>[
            // Botões para cancelar ou adicionar o contato, com ação de validação do formulário.
            // Botões aqui.
          ],
        );
      },
    );
  }

  // Método para adicionar um novo contato ao banco de dados e atualizar a interface.
  void _addContact() {
    final newContact = ContatoModel(
      id: int.parse(_idController.text),
      nome: _nomeController.text,
      email: _emailController.text,
   
    );

    dbHelper.create(newContact); // Cria um novo contato no banco de dados.
    setState(() {
      // Força a reconstrução do widget para atualizar a lista de contatos.
    });
  }
}
