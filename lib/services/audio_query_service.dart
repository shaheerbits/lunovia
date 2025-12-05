import 'package:on_audio_query/on_audio_query.dart';

class AudioQueryService {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<SongModel>> fetchSongs() async {
    return await _audioQuery.querySongs();
  }
}