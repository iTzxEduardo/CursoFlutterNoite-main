import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Teste Shared SharedPreferences",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light), // Define o tema padrão como claro
      darkTheme: ThemeData(brightness: Brightness.dark), // Define o tema escuro
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences _prefs; // Objeto para acessar as preferências compartilhadas
  bool _darkMode = false; // Estado que controla se o modo escuro está ativado ou não

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Carrega as preferências compartilhadas ao inicializar o widget
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance(); // Obtém uma instância de SharedPreferences
    setState(() {
      _darkMode = _prefs.getBool('darkMode') ?? false; // Carrega o estado do modo escuro, padrão é falso
    });
  }

  Future<void> _toggleDarkMode() async {
    setState(() {
      _darkMode = !_darkMode; // Alterna entre os modos claro e escuro
    });
    await _prefs.setBool('darkMode', _darkMode); // Salva o estado atual do modo escuro nas preferências compartilhadas
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: _darkMode
          ? ThemeData.dark() // Define o tema como escuro se o modo escuro estiver ativado
          : ThemeData.light(), // Define o tema como claro se o modo escuro estiver desativado
      duration: Duration(milliseconds: 500), // Define a duração da transição entre os temas
      child: Scaffold(
        appBar: AppBar(
          title: Text('Armazenamento Interno'),
        ),
        body: Center(
          child: Switch(
            value: _darkMode, // Define o valor do switch com base no estado do modo escuro
            onChanged: (value) {
              _toggleDarkMode(); // Ao alterar o switch, chama a função para alternar o modo escuro
            },
          ),
        ),
      ),
    );
  }
}
