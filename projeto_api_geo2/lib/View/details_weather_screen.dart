import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';
import 'package:weather_icons/weather_icons.dart';

import '../Model/city_model.dart';

class DetailsWeatherScreen extends StatefulWidget {
  final String city;
  const DetailsWeatherScreen({super.key, required this.city});

  @override
  State<DetailsWeatherScreen> createState() => _DetailsWeatherScreenState();
}

class _DetailsWeatherScreenState extends State<DetailsWeatherScreen> {
  final WeatherController _controller = WeatherController();
  final CityDataBaseService _dbService = CityDataBaseService();

  final Map<String, String> weatherTranslations = {
    "clear sky": "Céu limpo",
    "few clouds": "Poucas nuvens",
    "scattered clouds": "Nuvens dispersas",
    "broken clouds": "Nuvens quebradas",
    "shower rain": "Chuva de banho",
    "rain": "Chuva",
    "thunderstorm": "Trovoada",
    "snow": "Neve",
    "mist": "Névoa"
  };

  final Map<String, Color> weatherBackgroundColors = {
    "clear sky": Colors.blue,
    "few clouds": Colors.lightBlueAccent,
    "scattered clouds": Colors.blueGrey,
    "broken clouds": Colors.grey,
    "shower rain": Colors.indigo,
    "rain": Colors.blueAccent,
    "thunderstorm": Colors.deepPurple,
    "snow": Colors.white,
    "mist": Colors.blueGrey[200]!,
  };

  String translateWeather(String description) {
    return weatherTranslations[description.toLowerCase()] ?? description;
  }

  IconData getWeatherIcon(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return WeatherIcons.day_sunny;
      case 'few clouds':
        return WeatherIcons.day_cloudy;
      case 'scattered clouds':
      case 'broken clouds':
        return WeatherIcons.cloud;
      case 'shower rain':
        return WeatherIcons.showers;
      case 'rain':
        return WeatherIcons.rain;
      case 'thunderstorm':
        return WeatherIcons.thunderstorm;
      case 'snow':
        return WeatherIcons.snow;
      case 'mist':
        return WeatherIcons.fog;
      default:
        return WeatherIcons.day_sunny; // Default icon for unrecognized descriptions
    }
  }

  Color getBackgroundColor(String description) {
    return weatherBackgroundColors[description.toLowerCase()] ?? Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Tempo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: FutureBuilder(
            future: _controller.getWeather(widget.city),
            builder: (context, snapshot) {
              if (_controller.weatherList.isEmpty) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                );
              } else {
                final weather = _controller.weatherList.last;
                final backgroundColor = getBackgroundColor(weather.description);
                return Container(
                  color: backgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            weather.name,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.favorite),
                            onPressed: () {
                              //criar método para favoritar
                            },
                          )
                        ],
                      ),
                      Icon(
                        getWeatherIcon(weather.description),
                        size: 100.0,
                        color: Colors.white,
                      ),
                      Text(
                        translateWeather(weather.description),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        'Temperatura: ${(weather.temp - 273).toStringAsFixed(2)}°C',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
