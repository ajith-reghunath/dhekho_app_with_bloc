import 'package:bloc/bloc.dart';
import 'package:dhekho_app/Infrastructure/db_playlist_video.dart';
import 'package:dhekho_app/model/data_model.dart';
import 'package:meta/meta.dart';

part 'playlist_video_event.dart';
part 'playlist_video_state.dart';

class PlaylistVideoBloc extends Bloc<PlaylistVideoEvent, PlaylistVideoState> {
  final DbPlaylistVideo playlistVideoFunctions = DbPlaylistVideo();
  PlaylistVideoBloc() : super(PlaylistVideoInitial(playlistVideo: [])) {
    on<GetAllPlaylistVideo>((event, emit) async {
      final result = await playlistVideoFunctions.getAllPlaylistVideo();
      emit(PlaylistVideoState(playlistVideo: result));
    });
    on<AddToPlaylist>((event, emit) async {
      await playlistVideoFunctions.addtoPlaylist(event.value);
    });
    on<DeleteFromPlaylist>((event, emit) async {
      await playlistVideoFunctions.deleteFromPlaylist(event.id);
    });
  }
}
