part of 'playlist_video_bloc.dart';

class PlaylistVideoState {
  final List<PlaylistVideoModel> playlistVideo;
  PlaylistVideoState({required this.playlistVideo});
}

class PlaylistVideoInitial extends PlaylistVideoState {
  PlaylistVideoInitial({required super.playlistVideo});
}
