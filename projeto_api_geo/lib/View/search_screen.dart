import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Controller/weather_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final WeatherController _controller = WeatherController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cidadeController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesquisa Por Cidade")
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child:Form(
            key:_formKey,
            child: Column(
              children:[
                TextFormField(
                  decoration: const InputDecoration(labelText: "Insira a Cidade"),
                  controller: _cidadeController,
                  validator: (value){
                    if(value!.trim().isEmpty){
                      return "Insira a Cidade";
                    }
                    return null;
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _findCity(_cidadeController.text);
                    }
                  },
                  child: const Text ("Pesquisar"),
                )
              ]
            ))
        ),),
    );
  }
  Future<void> _findCity(String city) async {
    if(await _controller.findCity(city)){
      //snackbar
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text("Cidade encontrada!"),
          duration:  Duration(seconds: 1),
        ),
      );
      Navigator.pushNamed(context, "/details");
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
      const  SnackBar(
          content: Text("Cidade não encontrada!"),
          duration:  Duration(seconds: 2),
        ),
      );
    }
  }
}