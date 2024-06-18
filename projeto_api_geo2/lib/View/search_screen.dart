import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/city_db_controller.dart';
import '../Controller/weather_controller.dart';
import '../Model/city_model.dart';
import 'details_weather_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final WeatherController _controller = WeatherController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();
  final CityDbController _dbController = CityDbController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pesquisa Por Cidade")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Insira a Cidade"),
                    controller: _cityController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Insira a Cidade";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _findCity(_cityController.text);
                      }
                    },
                    child: const Text("Pesquisar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      textStyle: const TextStyle(fontSize: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Cidades Favoritas",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder(
                      future: _dbController.listCities(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Erro: ${snapshot.error}");
                        } else if (snapshot.hasData && _dbController.cities().isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _dbController.cities().length,
                            itemBuilder: (context, index) {
                              final city = _dbController.cities()[index];
                              return ListTile(
                                title: Text(city.cityName),
                                onTap: () {
                                  _findCity(city.cityName);
                                },
                              );
                            },
                          );
                        } else {
                          return const Text("Lista Vazia");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _findCity(String city) async {
    if (await _controller.findCity(city)) {
      City cidade = City(cityName: city, favoriteCities: 0);
      _dbController.addCities(cidade);
      print("ok");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cidade Encontrada!"),
          duration: Duration(seconds: 1),
        ),
      );
      setState(() {});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => DetailsWeatherScreen(city: city),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cidade não encontrada!"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
