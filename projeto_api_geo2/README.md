# projeto_api_geo

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

lib/
|-- models/
|  	    |-- weather.dart  // Definições de modelos para dados climáticos

|-- screens/
|   	|-- home_screen.dart  // Página inicial com previsão do tempo
|   	|-- favorites_screen.dart  // Página para gerenciar locais favoritos
|  	    |-- history_screen.dart  // Página para exibir histórico de consultas

|-- services/
|   	|-- weather_api.dart  // Serviço para lidar com a API de previsão do tempo
|   	|-- database.dart  // Serviço para lidar com operações do SQLite

|-- widgets/
|   	|-- weather_card.dart  // Widget para exibir informações climáticas
|  	|-- chart.dart  // Widget para exibir gráfico de tendências climáticas

|-- main.dart  // Ponto de entrada do aplicativo

