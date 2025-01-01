import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({Key? key}) : super(key: key);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  double progress = 0.0;
  Duration songDuration = Duration();
  Duration position = Duration();
  double volume = 0.5;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        songDuration = duration;
      });
    });

    _audioPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        position = p;
        progress = position.inMilliseconds / songDuration.inMilliseconds;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPauseAudio() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play('assets/audio/vlog.mp3', isLocal: true);
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Song Title
            Text(
              'Vlog Song',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            // Play/Pause Button
            IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: _playPauseAudio,
              iconSize: 50.0,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 20),

            // Song Progress Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  // Linear Progress Bar
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                  const SizedBox(height: 10),
                  // Song Duration and Position
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(position)),
                      Text(_formatDuration(songDuration)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Volume Slider
            Slider(
              value: volume,
              onChanged: (double value) {
                setState(() {
                  volume = value;
                  _audioPlayer.setVolume(volume);
                });
              },
              min: 0.0,
              max: 1.0,
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.grey,
            ),
            const SizedBox(height: 10),
            Text(
              'Volume: ${(volume * 100).toInt()}%',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}