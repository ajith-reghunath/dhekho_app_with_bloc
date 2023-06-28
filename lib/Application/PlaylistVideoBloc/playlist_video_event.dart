part of 'playlist_video_bloc.dart';

class PlaylistVideoEvent {}

class GetAllPlaylistVideo extends PlaylistVideoEvent {}

class AddToPlaylist extends PlaylistVideoEvent {
  final PlaylistVideoModel value;
  AddToPlaylist({required this.value});
}

class DeleteFromPlaylist extends PlaylistVideoEvent {
  final int id;
  DeleteFromPlaylist({required this.id});
}
