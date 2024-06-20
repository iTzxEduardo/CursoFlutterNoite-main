import 'package:audioplayers/audioplayers.dart';
import 'package:exemplo_audio_player/models/audio_model.dart';

class AudioController {
  final AudioPlayer _audioPlayer = AudioPlayer(); // Instância do AudioPlayer
  bool isPlaying = false; // Indicador de estado de reprodução
  Duration duration = Duration.zero; // Duração total do áudio
  Duration position = Duration.zero; // Posição atual do áudio
  late int currentIndex; // Índice atual na lista de áudios
  late List<AudioModel> audioList; // Lista de áudios

  // Getter para obter o áudio atual
  AudioModel get currentAudio => audioList[currentIndex];

  // Construtor
  AudioController({required this.audioList, required this.currentIndex}) {
    // Ouvinte para mudanças na duração do áudio
    _audioPlayer.onDurationChanged.listen((Duration d) {
      duration = d;
    });
    // Ouvinte para mudanças na posição do áudio
    _audioPlayer.onPositionChanged.listen((Duration p) {
      position = p;
    });
  }

  // Stream para mudanças na duração do áudio
  Stream<Duration> get onDurationChanged => _audioPlayer.onDurationChanged;
  // Stream para mudanças na posição do áudio
  Stream<Duration> get onPositionChanged => _audioPlayer.onPositionChanged;

  // Método para reproduzir ou pausar o áudio
  void playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause(); // Pausa o áudio se estiver tocando
    } else {
      await _audioPlayer.play(UrlSource(currentAudio.url)); // Reproduz o áudio se estiver pausado
    }
    isPlaying = !isPlaying; // Alterna o estado de reprodução
  }

  // Método para parar o áudio
  void stop() async {
    await _audioPlayer.stop();
    isPlaying = false; // Atualiza o estado de reprodução
    position = Duration.zero; // Reseta a posição do áudio
  }

  // Método para reiniciar o áudio
  void replay() async {
    await _audioPlayer.seek(Duration.zero); // Volta ao início do áudio
    await _audioPlayer.play(UrlSource(currentAudio.url)); // Reproduz o áudio desde o início
    isPlaying = true; // Atualiza o estado de reprodução
  }

  // Método para avançar para o próximo áudio
  void next() {
    if (currentIndex < audioList.length - 1) {
      currentIndex++;
      playNewAudio(); // Reproduz o novo áudio
    }
  }

  // Método para voltar ao áudio anterior
  void previous() {
    if (currentIndex > 0) {
      currentIndex--;
      playNewAudio(); // Reproduz o áudio anterior
    }
  }

  // Método para reproduzir um novo áudio
  void playNewAudio() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(currentAudio.url));
    isPlaying = true; // Atualiza o estado de reprodução
    position = Duration.zero; // Reseta a posição do áudio
  }

  // Método para buscar uma nova posição no áudio
  Future<void> seek(double value) async {
    final position = Duration(seconds: value.toInt());
    await _audioPlayer.seek(position); // Altera a posição do áudio
    this.position = position; // Atualiza a posição do áudio
  }

  // Método para liberar os recursos usados pelo player
  void dispose() {
    _audioPlayer.dispose();
  }

  // Método para formatar a duração em uma string legível
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0'); // Formata para dois dígitos
    final hours = duration.inHours; // Obtém as horas
    final minutes = twoDigits(duration.inMinutes.remainder(60)); // Obtém os minutos
    final seconds = twoDigits(duration.inSeconds.remainder(60)); // Obtém os segundos
    return [
      if (hours > 0) twoDigits(hours), // Inclui horas se houver
      minutes,
      seconds,
    ].join(':'); // Junta tudo em uma string
  }
}
