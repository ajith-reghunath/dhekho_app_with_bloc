part of 'load_videos_bloc.dart';

class LoadVideosState {
  final List<VideoModel> videoList;
  LoadVideosState({required this.videoList});
}

class LoadVideosInitial extends LoadVideosState {
  LoadVideosInitial({required super.videoList});
}
