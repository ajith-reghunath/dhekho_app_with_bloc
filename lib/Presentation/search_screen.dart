import 'package:dhekho_app/Application/LoadVideos/load_videos_bloc.dart';
import 'package:dhekho_app/Presentation/playing_screen.dart';
import 'package:dhekho_app/Infrastructure/db_function.dart';
import 'package:dhekho_app/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../Infrastructure/db_favourite.dart';
import '../Infrastructure/db_playlist.dart';
import '../Infrastructure/db_playlist_video.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? favouriteButton;
  Widget? favouriteicon;
  String search = '';
  @override
  Widget build(BuildContext context) {
    final b = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    List findlist = [];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
            child: TextField(
              autocorrect: true,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: const TextStyle(
                  fontFamily: 'Poppins', fontSize: 20, color: Colors.white),
              onChanged: (value) => setState(() {
                search = value;
              }),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 212, 235, 255), width: 1.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 181, 220, 254), width: 1.5),
                ),
                hintText: 'Search here',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 212, 235, 255),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              ),
            ),
          ),
          backgroundColor: const Color(0xFF362360),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 212, 235, 255),
      body: BlocBuilder<LoadVideosBloc, LoadVideosState>(
        builder: (context, state) {
          List<VideoModel> videoList = state.videoList;
          if (videoList.isEmpty) {
            return const Center(
              child: Text('No videos found'),
            );
          }
          if (search.isEmpty) {
            findlist = videoList;
          } else {
            findlist = videoList
                .where((element) => element.path
                    .toString()
                    .split("/")
                    .last
                    .toString()
                    .toLowerCase()
                    .contains(search.toLowerCase()))
                .toList();
          }
          if (findlist.isEmpty) {
            return const Center(
              child: Text('No videos found'),
            );
          }
          return SafeArea(
            child:

                // setState(() {
                //   findlist;
                // });
                ListView.builder(
              itemBuilder: ((_, int index) {
                final data = findlist[index];
                var title = data.path.toString().split("/").last;
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
                                      borderRadius: BorderRadius.circular(5),
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
                                  if (data.isFavourite == true) {
                                    favouriteButton = 'Remove from favourites';
                                    favouriteicon = const Icon(
                                      Icons.favorite_rounded,
                                      color: Color.fromARGB(255, 252, 97, 97),
                                    );
                                  } else {
                                    favouriteButton = 'Add to favourites';
                                    favouriteicon = const Icon(
                                      Icons.favorite_outline,
                                      color: Color.fromARGB(255, 252, 97, 97),
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
                                                fontWeight: FontWeight.w500),
                                          ),
                                          children: [
                                            //Add to favourites
                                            SimpleDialogOption(
                                              padding: const EdgeInsets.all(8),
                                              onPressed: (() {
                                                if (data.isFavourite == true) {
                                                  // deleteFromFavourites(
                                                  //     data.id!);
                                                  final videoBox =
                                                      Hive.box<VideoModel>(
                                                          'video_db');
                                                  VideoModel video =
                                                      videoBox.get(index)!;
                                                  video.isFavourite = false;
                                                  videoBox.put(index, video);

                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255, 38, 38, 38),
                                                      content: Text(
                                                        'Video has been removed from favourites',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              254, 253, 255),
                                                          fontSize: 0.042 * b,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                      duration: const Duration(
                                                          seconds: 3),
                                                    ),
                                                  );
                                                } else {
                                                  final favouritePath =
                                                      data.path;
                                                  final favouriteVideo =
                                                      FavouriteModel(
                                                          path: favouritePath,
                                                          isFavourite: true,
                                                          id: data.id);
                                                  // addToFavourite(
                                                  //     favouriteVideo);
                                                  final videoBox =
                                                      Hive.box<VideoModel>(
                                                          'video_db');
                                                  VideoModel video =
                                                      videoBox.get(index)!;
                                                  video.isFavourite = true;
                                                  videoBox.put(index, video);
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255, 38, 38, 38),
                                                      content: Text(
                                                        'Video has been added to favourites',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              254, 253, 255),
                                                          fontSize: 0.042 * b,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                      duration: const Duration(
                                                          seconds: 3),
                                                    ),
                                                  );
                                                }
                                              }),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: const Color.fromARGB(
                                                      255, 212, 235, 255),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12),
                                                      child: Text(
                                                        favouriteButton!,
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    26,
                                                                    26,
                                                                    26),
                                                            fontSize: 19,
                                                            fontFamily:
                                                                'Poppins'),
                                                      ),
                                                    ),
                                                    favouriteicon!
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Add to playlist
                                            SimpleDialogOption(
                                              padding: const EdgeInsets.all(8),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: const Color.fromARGB(
                                                      255, 212, 235, 255),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: const [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12),
                                                      child: Text(
                                                        'Add to playlist',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
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
                                                        const Color.fromARGB(
                                                            255, 212, 235, 255),
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontFamily:
                                                                      'Poppins'),
                                                            ),
                                                            const SizedBox(
                                                                height: 20),
                                                            Expanded(
                                                              child:
                                                                  ValueListenableBuilder(
                                                                valueListenable:
                                                                    playlistNotifier,
                                                                builder: ((BuildContext
                                                                        context,
                                                                    List<PlaylistModel>
                                                                        playList,
                                                                    child) {
                                                                  return ListView
                                                                      .builder(
                                                                    itemBuilder:
                                                                        ((_,
                                                                            int index) {
                                                                      final data1 =
                                                                          playList[
                                                                              index];
                                                                      return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            final model = PlaylistVideoModel(
                                                                                path: data.path,
                                                                                playlistId: data1.playlistId,
                                                                                isFavourite: data.isFavourite);
                                                                            // addtoPlaylist(model);
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(bottom: 10),
                                                                            child:
                                                                                Container(
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
                                                                    }),
                                                                    itemCount:
                                                                        playList
                                                                            .length,
                                                                  );
                                                                }),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    });
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
              }),
              itemCount: findlist.length,
            ),
          );
        },
      ),
    );
  }
}
