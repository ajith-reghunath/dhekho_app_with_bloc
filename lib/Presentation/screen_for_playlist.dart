import 'package:dhekho_app/Application/FavouritesBloc/favourites_bloc.dart';
import 'package:dhekho_app/Application/PlaylistVideoBloc/playlist_video_bloc.dart';
import 'package:dhekho_app/Presentation/playing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../Infrastructure/db_favourite.dart';
import '../Infrastructure/db_playlist.dart';
import '../Infrastructure/db_playlist_video.dart';
import '../model/data_model.dart';

// ignore: must_be_immutable

class ScreenForPlaylist extends StatelessWidget {
  String name;
  int playlistID;
  ScreenForPlaylist({super.key, required this.name, required this.playlistID});

  String? favouriteButton;
  Widget? favouriteicon;
  @override
  Widget build(BuildContext context) {
    final b = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    icon: const Icon(Icons.arrow_back_ios)),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 25,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 0.1 * b,
                )
              ],
            ),
          ),
          backgroundColor: const Color(0xFF362360),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 212, 235, 255),
      body: Column(
        children: [
          BlocBuilder<PlaylistVideoBloc, PlaylistVideoState>(
            builder: (context, state) {
              List<PlaylistVideoModel> playlistvideo = state.playlistVideo;
              return Expanded(
                child: ListView.builder(
                  itemCount: playlistvideo.length,
                  itemBuilder: ((_, int index) {
                    if (playlistvideo[index].playlistId == playlistID) {
                      final data = playlistvideo[index];
                      var title = data.path.toString().split("/").last;

                      // opening box of video model
                      final videoBox = Hive.box<VideoModel>('video_db');
                      VideoModel? videoFound = videoBox.values.firstWhere(
                        (element) => element.path == data.path,
                      );

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) {
                                return PlayingScreen(videopath: data.path);
                              }),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 130,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/Thumbnail.png'),
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 0.42 * b,
                                    child: Text(
                                      title,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 19,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: (() {
                                        if (videoFound.isFavourite == true) {
                                          favouriteButton =
                                              'Remove from favourites';
                                          favouriteicon = const Icon(
                                            Icons.favorite_rounded,
                                            color: Color.fromARGB(
                                                255, 252, 97, 97),
                                          );
                                        } else {
                                          favouriteButton = 'Add to favourites';
                                          favouriteicon = const Icon(
                                            Icons.favorite_outline,
                                            color: Color.fromARGB(
                                                255, 252, 97, 97),
                                          );
                                        }
                                        showDialog(
                                          context: context,
                                          builder: ((context) => SimpleDialog(
                                                title: const Text(
                                                  'Select one',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                children: [
                                                  //Add to favourites
                                                  BlocBuilder<FavouritesBloc,
                                                      FavouritesState>(
                                                    builder: (context, state) {
                                                      return SimpleDialogOption(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        onPressed: (() {
                                                          if (videoFound
                                                                  .isFavourite ==
                                                              true) {
                                                            context
                                                                .read<
                                                                    FavouritesBloc>()
                                                                .add(DeleteFromFavouritesUsingPath(
                                                                    path: data
                                                                        .path));
                                                            // deleteFromFavouritesUsingPath(
                                                            //     data.path);

                                                            videoFound
                                                                    .isFavourite =
                                                                false;
                                                            videoBox.put(
                                                                videoFound.id,
                                                                videoFound);

                                                            // final videoBox = Hive
                                                            //     .box<VideoModel>(
                                                            //         'video_db');
                                                            // VideoModel video =
                                                            //     videoBox
                                                            //         .get(index)!;
                                                            // video.isFavourite =
                                                            //     false;
                                                            // videoBox.put(
                                                            //     index, video);

                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                backgroundColor:
                                                                    const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        38,
                                                                        38,
                                                                        38),
                                                                content: Text(
                                                                  'Video has been removed from favourites',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        254,
                                                                        253,
                                                                        255),
                                                                    fontSize:
                                                                        0.042 *
                                                                            b,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                  ),
                                                                ),
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            3),
                                                              ),
                                                            );
                                                          } else {
                                                            final favouritePath =
                                                                data.path;
                                                            final favouriteVideo =
                                                                FavouriteModel(
                                                                    path:
                                                                        favouritePath,
                                                                    isFavourite:
                                                                        true,
                                                                    id: videoFound
                                                                        .id);
                                                            context
                                                                .read<
                                                                    FavouritesBloc>()
                                                                .add(AddToFavourite(
                                                                    value:
                                                                        favouriteVideo));
                                                            // addToFavourite(
                                                            //     favouriteVideo);
                                                            videoFound
                                                                    .isFavourite =
                                                                true;
                                                            videoBox.put(
                                                                videoFound.id,
                                                                videoFound);
                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                backgroundColor:
                                                                    const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        38,
                                                                        38,
                                                                        38),
                                                                content: Text(
                                                                  'Video has been added to favourites',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        254,
                                                                        253,
                                                                        255),
                                                                    fontSize:
                                                                        0.042 *
                                                                            b,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                  ),
                                                                ),
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            3),
                                                              ),
                                                            );
                                                          }
                                                        }),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                212,
                                                                235,
                                                                255),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        12),
                                                                child: Text(
                                                                  favouriteButton!,
                                                                  style: const TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          26,
                                                                          26,
                                                                          26),
                                                                      fontSize:
                                                                          19,
                                                                      fontFamily:
                                                                          'Poppins'),
                                                                ),
                                                              ),
                                                              favouriteicon!
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  // Add to playlist
                                                  BlocBuilder<PlaylistVideoBloc,
                                                      PlaylistVideoState>(
                                                    builder: (context, state) {
                                                      return SimpleDialogOption(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                212,
                                                                235,
                                                                255),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: const [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            12),
                                                                child: Text(
                                                                  'Remove from playlist',
                                                                  style: TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          26,
                                                                          26,
                                                                          26),
                                                                      fontSize:
                                                                          19,
                                                                      fontFamily:
                                                                          'Poppins'),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            12),
                                                                child: Icon(Icons
                                                                    .minimize),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                  PlaylistVideoBloc>()
                                                              .add(DeleteFromPlaylist(
                                                                  id: data
                                                                      .id!));
                                                          context
                                                              .read<
                                                                  PlaylistVideoBloc>()
                                                              .add(
                                                                  GetAllPlaylistVideo());
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              backgroundColor:
                                                                  const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      38,
                                                                      38,
                                                                      38),
                                                              content: Text(
                                                                '$title is removed from ${name}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      254,
                                                                      253,
                                                                      255),
                                                                  fontSize:
                                                                      0.045 * b,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ),
                                                              ),
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          3),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  )
                                                ],
                                              )),
                                        );
                                      }),
                                      icon: const Icon(Icons.more_vert))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox(
                        width: 1,
                      );
                    }
                  }),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
