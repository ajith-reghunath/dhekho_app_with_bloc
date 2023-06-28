part of 'playlist_bloc.dart';

class PlaylistEvent {}

class DisplayPlaylist extends PlaylistEvent {}

class AddPlaylist extends PlaylistEvent {
  final PlaylistModel playlist;
  AddPlaylist({required this.playlist});
}

class DeletePlaylist extends PlaylistEvent {
  final int index;
  DeletePlaylist({required this.index});
}
