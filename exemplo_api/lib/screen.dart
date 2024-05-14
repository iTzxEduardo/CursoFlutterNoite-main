import 'package:flutter/material.dart';
import 'service.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService(
    apiKey: '681126f28e7d6fa3a7cfe0da0671e599',
    baseUrl: 'https://api.openweathermap.org/data/2.5',
  );

  late Map<String, dynamic> _weatherData = {};

  @override
  void initState() {
    super.initState();
    _fetchWeatherData('Rio de Janeiro');
  }

  Future<void> _fetchWeatherData(String city) async {
    try {
      final weatherData = await _weatherService.getWeather(city);
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Exemplo Weather-API'),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(12),
  //       child: FutureBuilder(
  //         future: _fetchWeatherData("Limeira"),
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return Center(
  //               child: CircularProgressIndicator(),
  //             );
  //           } else if (snapshot.hasError) {
  //             return Center(
  //               child: Text('Error: ${snapshot.error}'),
  //             );
  //           } else {
  //             return Center(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text('City: ${_weatherData['name'] ?? ''}'), // Exibe o nome da cidade.
  //                   Text('Temperature: ${(_weatherData['main']['temp'] ?? 0) - 273} °C'), // Exibe a temperatura em graus Celsius.
  //                   Text('Description: ${_weatherData['weather'][0]['description'] ?? ''}'),
  //                 ],
  //               ),
  //             );
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo Weather-API'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder(
          future: _fetchWeatherData("Limeira"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('City: ${_weatherData['name'] ?? ''}'), // Exibe o nome da cidade.
                    Text('Temperature: ${(_weatherData['main']['temp'] ?? 0) - 273} °C'), // Exibe a temperatura em graus Celsius.
                    Text('Description: ${_weatherData['weather'][0]['description'] ?? ''}'),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
