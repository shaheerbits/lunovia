import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerProvider  extends ChangeNotifier {
  PlayerProvider() {
    _listenDuration();
  }

  final AudioPlayer _player = AudioPlayer();
  List<SongModel> _songs = [];
  var _currentSongIndex = -1;
  var isPlaying = false;

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  List<SongModel> get songs => _songs;
  int get currentSongIndex => _currentSongIndex;
  AudioPlayer get player => _player;

  SongModel? get currentSong =>
      (_currentSongIndex >= 0 && _currentSongIndex < _songs.length)
          ? _songs[_currentSongIndex]
          : null;

  bool get hasNext => _currentSongIndex < _songs.length - 1;
  bool get hasPrevious => _currentSongIndex > 0;

  void setSongs(List<SongModel> songs) {
    _songs = songs;
    notifyListeners();
  }

  Future<void> play() async {
    await _player.play(DeviceFileSource(_songs[_currentSongIndex].data));
    isPlaying = true;
    notifyListeners();
  }

  Future<void> playAtIndex(int index) async {
      if(index >= _songs.length || index < 0) return;
      _currentSongIndex = index;

      await _player.stop();
      await _player.play(DeviceFileSource(_songs[_currentSongIndex].data));
      notifyListeners();
  }

  Future<void> pause() async {
    _player.pause();
    isPlaying = false;
    notifyListeners();
  }

  Future<void> playNext() async {
    if (!hasNext) return;
    await playAtIndex(_currentSongIndex + 1);
  }

  Future<void> playPrevious() async {
    if (!hasPrevious) return;
    await playAtIndex(_currentSongIndex - 1);
  }

  void _listenDuration() {
    _player.onDurationChanged.listen((duration) {
      _totalDuration = duration;
      notifyListeners();
    });

    _player.onPositionChanged.listen((duration) {
      _currentDuration = duration;
      notifyListeners();
    });

    _player.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
      notifyListeners();
    });
  }
}