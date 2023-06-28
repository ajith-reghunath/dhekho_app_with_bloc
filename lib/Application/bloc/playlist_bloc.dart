import 'package:bloc/bloc.dart';
import 'package:dhekho_app/Infrastructure/db_playlist.dart';
import 'package:dhekho_app/model/data_model.dart';
import 'package:meta/meta.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final DbPlaylistFunctions playlistDbFunctions = DbPlaylistFunctions();
  PlaylistBloc() : super(PlaylistInitial(playlist: [])) {
    on<DisplayPlaylist>((event, emit) async {
      final result = await playlistDbFunctions.getAllPlaylist();
      emit(PlaylistState(playlist: result));
    });
    on<AddPlaylist>((event, emit) async {
      await playlistDbFunctions.addPlaylist(event.playlist);
    });
    on<DeletePlaylist>((event, emit) async {
      await playlistDbFunctions.deletePlaylist(event.index);
    });
  }
}
