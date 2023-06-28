import 'package:dhekho_app/model/data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';


class DbPlaylistVideo {
  Future<void> addtoPlaylist(PlaylistVideoModel value) async {
    final playlistVideoDB =
        await Hive.openBox<PlaylistVideoModel>('playlistvideo_db');
    final id = await playlistVideoDB.add(value);
    value.id = id;
    playlistVideoDB.put(id, value);
  }

  Future<List<PlaylistVideoModel>> getAllPlaylistVideo() async {
    final playlistVideoDB =
        await Hive.openBox<PlaylistVideoModel>('playlistvideo_db');
    return playlistVideoDB.values.toList();
  }

  Future<void> deleteFromPlaylist(int id) async {
    final playlistVideoDB =
        await Hive.openBox<PlaylistVideoModel>('playlistvideo_db');
    PlaylistVideoModel playlistvideo = playlistVideoDB.values
        .firstWhere((playlistvideo) => playlistvideo.id == id);
    playlistVideoDB.delete(playlistvideo.id);
    // await getAllPlaylistVideo();
  }
}
