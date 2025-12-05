import 'package:flutter/material.dart';
import 'package:lunovia/providers/player_provider.dart';
import 'package:lunovia/providers/songs_provider.dart';
import 'package:lunovia/utils/format_duration.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({super.key});

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  late SongsProvider songsProvider;
  late PlayerProvider playerProvider;
  final FormatDuration _formatDuration = FormatDuration();

  @override
  void initState() {
    super.initState();
    songsProvider = context.read<SongsProvider>();
    playerProvider = context.read<PlayerProvider>();
    initSongsPage();
  }

  Future<void> initSongsPage() async {
    var permissionStatus = await Permission.audio.request();
    if (permissionStatus.isGranted) {
      await songsProvider.loadSongs();
      playerProvider.setSongs(songsProvider.songs);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<SongsProvider>(
          builder: (context, songsProvider, _) {
            final songs = songsProvider.songs;
            return songsProvider.isLoading
                ? Center(child: CircularProgressIndicator.adaptive())
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final song = songs[index];
                      return InkWell(
                        onTap: () async {
                          await playerProvider.playAtIndex(index);
                        },
                        child: Container(
                          margin: EdgeInsetsDirectional.only(bottom: 8),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: 24,
                            children: [
                              QueryArtworkWidget(
                                artworkWidth: 60,
                                artworkHeight: 60,
                                id: song.id,
                                type: ArtworkType.AUDIO,
                                artworkQuality: FilterQuality.high,
                                artworkBorder: BorderRadius.circular(12),
                                nullArtworkWidget: Icon(Icons.music_note),
                                keepOldArtwork: true,
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      song.title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                      ),
                                    ),

                                    Text(
                                      song.artist ?? 'Unknown',
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                _formatDuration.formatDuration(
                                  Duration(milliseconds: song.duration ?? 0),
                                ),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),

        Consumer<PlayerProvider>(
          builder: (context, player, _) {
            if (player.currentSong == null) return SizedBox.shrink();
            final song = player.currentSong!;

            return Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  spacing: 24,
                  children: [
                    QueryArtworkWidget(
                      id: song.id,
                      type: ArtworkType.AUDIO,
                      artworkQuality: FilterQuality.high,
                      artworkBorder: BorderRadius.circular(12),
                      nullArtworkWidget: Icon(Icons.music_note),
                      keepOldArtwork: true,
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            song.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            song.artist ?? "Unknown",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        player.isPlaying ? player.pause() : player.play();
                      },
                      child: Icon(
                        player.isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
