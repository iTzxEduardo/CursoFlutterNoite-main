import 'package:exemplo_audio_player/models/audio_model.dart';
import 'package:flutter/material.dart';
import '../Controller/audio_controller.dart';

class AudioPlayerScreen extends StatefulWidget {
  final List<AudioModel> audioList;
  final int initialIndex;
  const AudioPlayerScreen({super.key, required this.audioList, required this.initialIndex});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioController _audioController;

  @override
  void initState() {
    super.initState();
    _audioController = AudioController(audioList: widget.audioList, currentIndex: widget.initialIndex);
    _audioController.onDurationChanged.listen((Duration d) {
      setState(() {
        _audioController.duration = d;
      });
    });
    _audioController.onPositionChanged.listen((Duration p) {
      setState(() {
        _audioController.position = p;
      });
    });
  }

  @override
  void dispose() {
    _audioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_audioController.currentAudio.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_audioController.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill),
              iconSize: 64.0,
              onPressed: () {
                setState(() {
                  _audioController.playPause();
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.replay_circle_filled),
              iconSize: 64.0,
              onPressed: () {
                setState(() {
                  _audioController.replay();
                });
              },
            ),
            Slider(
              min: 0,
              max: _audioController.duration.inSeconds.toDouble(),
              value: _audioController.position.inSeconds.toDouble(),
              onChanged: (double value) async {
                await _audioController.seek(value);
                setState(() {});
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_audioController.formatDuration(_audioController.position)),
                  Text(_audioController.formatDuration(_audioController.duration)),
                ],
              ),
            ),
            Text(
              _audioController.isPlaying ? 'Playing' : 'Paused',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  iconSize: 48.0,
                  onPressed: () {
                    setState(() {
                      _audioController.previous();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  iconSize: 48.0,
                  onPressed: () {
                    setState(() {
                      _audioController.next();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}