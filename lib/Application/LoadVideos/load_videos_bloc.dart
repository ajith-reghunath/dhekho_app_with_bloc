import 'package:bloc/bloc.dart';
import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:meta/meta.dart';

import '../../Infrastructure/db_function.dart';
import '../../Presentation/playing_screen.dart';
import '../../model/data_model.dart';

part 'load_videos_event.dart';
part 'load_videos_state.dart';

class LoadVideosBloc extends Bloc<LoadVideosEvent, LoadVideosState> {
  final DbFunctions functionsDB = DbFunctions();
  LoadVideosBloc() : super(LoadVideosInitial(videoList: [])) {
    on<LoadVideos>((event, emit) async {
      final result = await functionsDB.getAllVideos();
      emit(LoadVideosState(videoList: result));
    });
    on<GetVideos>((event, emit) async {
      await functionsDB.checkVideo();
      FetchAllVideos ob = FetchAllVideos();
      videos = await ob.getAllVideos();
      for (var i = 0; i < videos.length; i++) {
        String path = videos[i];
        final video = VideoModel(path: path);
        await functionsDB.addVideo(video);
        // addVideo(video);
      }
    });
  }
}
