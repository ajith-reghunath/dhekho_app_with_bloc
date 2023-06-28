import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController videoplayercontroller;
  const VideoPlayerWidget({required this.videoplayercontroller, super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    widget.videoplayercontroller.initialize().then(((value) {
      setState(() => _chewieController = ChewieController(
          videoPlayerController: widget.videoplayercontroller,
          aspectRatio: widget.videoplayercontroller.value.aspectRatio,
          autoPlay: true,
          looping: true,
          ));
    }));
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoplayercontroller.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.videoplayercontroller.value.isInitialized
        ? Chewie(controller: _chewieController)
        : const SizedBox.shrink();
    
  }
}
