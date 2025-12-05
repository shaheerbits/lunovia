import 'package:flutter/material.dart';
import 'package:lunovia/services/audio_query_service.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsProvider extends ChangeNotifier {
  final AudioQueryService _audioQueryService = AudioQueryService();
  List<SongModel> _songs = [];
  bool isLoading = false;

  List<SongModel> get songs => _songs;

  Future<void> loadSongs() async {
    isLoading = true;
    notifyListeners();

    final result = await _audioQueryService.fetchSongs();
    _songs = result;

    isLoading = false;
    notifyListeners();
  }
}