import 'package:audioplayers/audioplayers.dart';
import 'package:exemplo_audio_player/models/audio_model.dart';
import 'package:flutter/material.dart';

class AudioPlayerScreen extends StatefulWidget {
  final AudioModel audio;
  const AudioPlayerScreen({super.key, required this.audio});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer = AudioPlayer();
    // _audioPlayer.setSource(UrlSource(widget.audio.url));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _audioPlayer.dispose();
    super.dispose();
  }
  
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    setState(() {
      _isPlaying =!_isPlaying;
    });
  }
  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(UrlSource(widget.audio.url));
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.audio.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isPlaying? Icons.pause : Icons.play_arrow),
              iconSize: 64.0,
              onPressed: () {
                _playPause();
              },
            ),
            Text(
              _isPlaying? 'Pausado' : 'Reproduzindo',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  
}