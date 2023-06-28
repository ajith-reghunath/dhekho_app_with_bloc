part of 'playlist_bloc.dart';

class PlaylistState {
  final List<PlaylistModel> playlist;
  PlaylistState({required this.playlist});
}

class PlaylistInitial extends PlaylistState {
  PlaylistInitial({required super.playlist});
}
