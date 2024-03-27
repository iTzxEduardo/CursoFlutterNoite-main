import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuDrawer(),
    );
  }
}

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu de Opções'),
        // Botão para abrir o Drawer
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Opções do Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Opção 1'),
              onTap: () {
                // Adicione a lógica para ação quando a opção 1 for selecionada
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Opção 2'),
              onTap: () {
                // Adicione a lógica para ação quando a opção 2 for selecionada
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Opção 3'),
              onTap: () {
                // Adicione a lógica para ação quando a opção 3 for selecionada
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Corpo da Aplicação'),
      ),
    );
  }
}
