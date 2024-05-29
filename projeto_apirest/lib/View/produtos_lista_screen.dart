import 'package:flutter/material.dart';
import 'package:projeto_apirest/Controller/produtos_controller.dart';

class ListaScreen extends StatefulWidget {
  const ListaScreen({super.key});

  @override
  State<ListaScreen> createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {

  final ProdutosController _controller = ProdutosController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder(
            future: _controller.getProdutos(), 
            builder: (context,snapshot){
              if(_controller.produtos.isNotEmpty){
                return ListView.builder(
                  itemCount: _controller.produtos.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      title: Text(_controller.produtos[index].nome),
                      subtitle: Text(_controller.produtos[index].codigo),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){
                          //método de delete do produto
                        },
                      ),
                    );
                  },
                );
              }else{
                return const CircularProgressIndicator();
              }
            }),
        ),
      ),
    );
  }
}