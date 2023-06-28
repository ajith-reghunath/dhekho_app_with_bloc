import 'package:dhekho_app/Application/FavouritesBloc/favourites_bloc.dart';
import 'package:dhekho_app/Application/PlaylistVideoBloc/playlist_video_bloc.dart';
import 'package:dhekho_app/Application/bloc/playlist_bloc.dart';
import 'package:dhekho_app/Presentation/playing_screen.dart';
import 'package:dhekho_app/Infrastructure/db_favourite.dart';
import 'package:dhekho_app/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../Infrastructure/db_playlist.dart';
import '../Infrastructure/db_playlist_video.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final b = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          centerTitle: true,
          title: const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              'Favourites',
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500),
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
          BlocBuilder<FavouritesBloc, FavouritesState>(
            builder: (context, state) {
              List<FavouriteModel> videoList = state.favouritesList;
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (_, int index) {
                    final data = videoList[index];
                    var title = data.path.toString().split("/").last;
                    // print(data.path);
                    // print(data.id);
                    // print(data.isFavourite);
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) {
                              return PlayingScreen(
                                videopath: data.path,
                              );
                            }),
                          ),
                        );
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  width: 150,
                                  child: Text(
                                    title,
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: (() {
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
                                                //favourites
                                                BlocBuilder<FavouritesBloc,
                                                    FavouritesState>(
                                                  builder: (context, state) {
                                                    return SimpleDialogOption(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        onPressed: (() {
                                                          context
                                                              .read<
                                                                  FavouritesBloc>()
                                                              .add(DeleteFromFavourites(
                                                                  id2: data
                                                                      .id!));
                                                          context
                                                              .read<
                                                                  FavouritesBloc>()
                                                              .add(
                                                                  GetAllFavourites());
                                                          // deleteFromFavourites(
                                                          //     data.id!);
                                                          final videoBox = Hive
                                                              .box<VideoModel>(
                                                                  'video_db');
                                                          VideoModel video =
                                                              videoBox.get(
                                                                  data.id)!;
                                                          video.isFavourite =
                                                              false;
                                                          videoBox.put(
                                                              data.id, video);

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
                                                                      0.042 * b,
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
                                                            children: const [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            12),
                                                                child: Text(
                                                                  'Remove from favourites',
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
                                                              Icon(
                                                                Icons
                                                                    .favorite_rounded,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        252,
                                                                        97,
                                                                        97),
                                                              )
                                                            ],
                                                          ),
                                                        ));
                                                  },
                                                ),
                                                // playlist
                                                SimpleDialogOption(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              212,
                                                              235,
                                                              255),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
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
                                                            'Add to playlist',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        26,
                                                                        26,
                                                                        26),
                                                                fontSize: 19,
                                                                fontFamily:
                                                                    'Poppins'),
                                                          ),
                                                        ),
                                                        Icon(Icons.add)
                                                      ],
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    showModalBottomSheet(
                                                        backgroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                212,
                                                                235,
                                                                255),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        context: context,
                                                        builder: (context) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 25,
                                                                    left: 18,
                                                                    right: 18),
                                                            child: Column(
                                                              children: [
                                                                const Text(
                                                                  'Add to Playlist',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          22,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontFamily:
                                                                          'Poppins'),
                                                                ),
                                                                const SizedBox(
                                                                    height: 20),
                                                                BlocBuilder<
                                                                    PlaylistBloc,
                                                                    PlaylistState>(
                                                                  builder:
                                                                      (context,
                                                                          state) {
                                                                    context
                                                                        .read<
                                                                            PlaylistBloc>()
                                                                        .add(
                                                                            DisplayPlaylist());
                                                                    List<PlaylistModel>
                                                                        playList =
                                                                        state
                                                                            .playlist;
                                                                    return Expanded(
                                                                      child: ListView
                                                                          .builder(
                                                                        itemBuilder:
                                                                            ((_,
                                                                                int index) {
                                                                          final data1 =
                                                                              playList[index];
                                                                          return BlocBuilder<
                                                                              PlaylistVideoBloc,
                                                                              PlaylistVideoState>(
                                                                            builder:
                                                                                (context, state) {
                                                                              return GestureDetector(
                                                                                  onTap: () {
                                                                                    final model = PlaylistVideoModel(path: data.path, playlistId: data1.playlistId, isFavourite: data.isFavourite, name: data1.name);
                                                                                    checkVideo(model);
                                                                                  },
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.only(bottom: 10),
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(5),
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      height: 0.06 * h,
                                                                                      width: 0.7 * b,
                                                                                      child: Center(
                                                                                        child: Text(data1.name,
                                                                                            style: const TextStyle(
                                                                                              fontSize: 19,
                                                                                              fontFamily: 'Poppins',
                                                                                            )),
                                                                                      ),
                                                                                    ),
                                                                                  ));
                                                                            },
                                                                          );
                                                                        }),
                                                                        itemCount:
                                                                            playList.length,
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  },
                                                ),
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
                  },
                  itemCount: videoList.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void checkVideo(PlaylistVideoModel model) async {
    final playlistVideoDB =
        await Hive.openBox<PlaylistVideoModel>('playlistvideo_db');
    final List<PlaylistVideoModel> playlistVideos =
        playlistVideoDB.values.toList();
    for (var video in playlistVideos) {
      if (video.path == model.path && video.playlistId == model.playlistId) {
        showDialog(
            context: context,
            builder: ((context) => SimpleDialog(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Text(
                        'This video is already in ${model.name} playlist',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: 'Poppins'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: (() {
                            Navigator.pop(context);
                          }),
                          child: const Text(
                            'Ok, got it',
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                          )),
                    )
                  ],
                )));
        // print('this video is already in the playlist');
        return;
      }
    }
    // addtoPlaylist(model);
    context.read<PlaylistVideoBloc>().add(AddToPlaylist(value: model));
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 38, 38, 38),
        content: Text(
          'Video has been added to ${model.name}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(255, 254, 253, 255),
            fontSize: 18,
            fontFamily: 'Poppins',
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
