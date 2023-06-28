import 'dart:io';
import 'package:dhekho_app/Presentation/video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

List videos = [];
// ignore: prefer_typing_uninitialized_variables
var pathvideo;

class PlayingScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final videopath;
  const PlayingScreen({super.key, required this.videopath});

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  @override
  Widget build(BuildContext context) {
    final b = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    pathvideo = widget.videopath;
    final videoplayerWidget = VideoPlayerWidget(
        videoplayercontroller: VideoPlayerController.file(File(pathvideo)));
    var title = pathvideo.toString().split("/").last;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      body: FittedBox(
        child: Stack(
          children: [
            videoplayerWidget,
            Padding(
              padding: EdgeInsets.only(top: 0.036*h),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 0.8* b,
                    height: 32,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 19,
                        color: Colors.white
                      ),
                    ),
                  ),
                  // Text(
                  //   title,
                  //   style: const TextStyle(
                  //     fontSize: 20,
                  //     color: Colors.white,
                  //     fontFamily: 'Poppins',
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [IconButton(onPressed: (() {

        //   }), icon: Icon(Icons.arrow_back_ios)),videoplayerWidget],
        // ),
      ),
    );
  }
}
