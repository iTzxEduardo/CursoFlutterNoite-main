import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Página de configurações que é um StatefulWidget
class ConfiguracoesPage extends StatefulWidget {
  // Atributo para armazenar o email do usuário
  final String email;

  // Construtor que recebe o email como parâmetro
  ConfiguracoesPage({required this.email});

  @override
  _ConfiguracoesPageState createState() =>
  _ConfiguracoesPageState(email: email); // Cria uma instância do estado da página de configurações
}

// Estado da página de configurações
class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  // Atributos
  late SharedPreferences _prefs; // Objeto para acessar as preferências compartilhadas
  bool _darkMode = false; // Estado do modo escuro
  final String email; // Email do usuário
  String _idioma = 'pt-br'; // Idioma selecionado

  // Construtor que inicializa o estado com o email recebido
  _ConfiguracoesPageState({required this.email});

  // Método chamado quando o widget é inicializado
  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Carrega as preferências do usuário
  }

  // Método para carregar as preferências do usuário
  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance(); // Obtém uma instância de SharedPreferences
    setState(() {
      // Atualiza o estado com base nas preferências armazenadas
      _darkMode = _prefs.getBool('${email}darkMode') ?? false;
      _idioma = _prefs.getString('${email}SelIdioma') ?? 'pt-br';
    });
  }

  // Método para alterar o modo escuro
  Future<void> _mudarDarkMode() async {
    setState(() {
      // Alterna entre modo escuro e claro
      _darkMode = !_darkMode;
    });
    await _prefs.setBool('${email}darkMode', _darkMode); // Salva a preferência do modo escuro
  }

  // Método para alterar o idioma
  Future<void> _mudarIdoma() async {
    setState(() {
      // Lógica para mudar o idioma (aqui seria onde você chamaria uma API, mas está como comentário)
    });
    await _prefs.setString('${email}SelIdioma', _idioma); // Salva a preferência do idioma
  }

  // Método de construção do widget
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: _darkMode
          ? ThemeData.dark() // Define o tema como escuro se o modo escuro estiver ativado
          : ThemeData.light(), // Caso contrário, usa o tema claro
      duration: Duration(milliseconds: 500), // Define a duração da transição de tema
      child: Scaffold(
        appBar: AppBar(
          title: Text('Teste de Armazenamento Interno'), // Título da barra de aplicativos
        ),
        body: Center(
          child: Column(
            children: [
              Text("Selecione o Modo Escuro"), // Texto explicativo
              Switch(
                value: _darkMode, // Valor do switch é baseado no modo escuro atual
                onChanged: (value) {
                  _mudarDarkMode(); // Método chamado ao mudar o estado do switch
                },
              ),
              Text("Selecione o Idioma"), // Texto explicativo
              DropdownButton<String>(
                value: _idioma, // Valor selecionado do dropdown é baseado no idioma atual
                onChanged: (value) {
                  _mudarIdoma(); // Método chamado ao mudar o idioma selecionado
                },
                items: <DropdownMenuItem<String>>[
                  // Itens do dropdown com diferentes idiomas
                  DropdownMenuItem(
                    value: 'pt-br',
                    child: Text('Português (Brasil)'),
                  ),
                  DropdownMenuItem(
                    value: 'en-us',
                    child: Text('Inglês (EUA)'),
                  ),
                  DropdownMenuItem(
                    value: 'es-ar',
                    child: Text('Espanhol (Argentina)'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
