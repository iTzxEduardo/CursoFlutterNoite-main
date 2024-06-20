import 'package:exemplo_audio_player/screens/audio_player_screen.dart';
import 'package:exemplo_audio_player/services/audio_service.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioService _service = AudioService();
  late Future<void> _audioListFuture;

  @override
  void initState() {
    super.initState();
    _audioListFuture = _getAudioList();
  }

  Future<void> _getAudioList() async {
    try {
      await _service.fetchAudio();
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _audioListFuture = _getAudioList();
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _audioListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar áudios: ${snapshot.error}'),
              );
            } else if (_service.list.isEmpty) {
              return const Center(
                child: Text('No Audio Found'),
              );
            } else {
              return ListView.builder(
                itemCount: _service.list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_service.list[index].title),
                    subtitle: Text(_service.list[index].artist),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AudioPlayerScreen(
                            audioList: _service.list,
                            initialIndex: index,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}