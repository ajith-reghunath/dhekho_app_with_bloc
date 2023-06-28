import 'package:dhekho_app/Application/FavouritesBloc/favourites_bloc.dart';
import 'package:dhekho_app/Application/LoadVideos/load_videos_bloc.dart';
import 'package:dhekho_app/Application/PlaylistVideoBloc/playlist_video_bloc.dart';
import 'package:dhekho_app/Infrastructure/db_function.dart';
import 'package:dhekho_app/model/data_model.dart';
import 'package:dhekho_app/Presentation/playing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:dhekho_app/Application/bloc/playlist_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // getAllPlaylist();
    super.initState();
  }

  String? favouriteButton;
  Widget? favouriteicon;
  @override
  Widget build(BuildContext context) {
    final b = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      // drawer: const Drawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          leading: IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(top: 22, left: 18),
              child: Icon(Icons.menu),
            ),
            onPressed: () {
              if (scaffoldKey.currentState!.isDrawerOpen) {
                scaffoldKey.currentState!.closeDrawer();
                //close drawer, if drawer is open
              } else {
                scaffoldKey.currentState!.openDrawer();
                //open drawer, if drawer is closed
              }
            },
          ),
          centerTitle: true,
          title: const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              'DHEKHO',
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: const Color(0xFF362360),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        ),
      ),
      drawer: Drawer(
        width: 0.65 * b,
        child: Container(
          color: const Color.fromARGB(255, 212, 235, 255),
          child: ListView(
            children: [
              const DrawerHeader(
                  child: Center(
                child: Text(
                  'DHEKHO',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
              )),
              ListTile(
                iconColor: Colors.black,
                leading: const Icon(Icons.info_outline),
                title: const Text(
                  'About Dhekho',
                  style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'Poppins',
                  ),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: ((context) => SizedBox(
                            width: 0.9 * b,
                            height: 0.8 * h,
                            child: SimpleDialog(
                              title: const Text(
                                'About Dhekho',
                                softWrap: true,
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5),
                                  child: SizedBox(
                                      height: 0.45 * h,
                                      width: 0.9 * b,
                                      child: SingleChildScrollView(
                                          child: Text(
                                        aboutUsText(),
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16),
                                      ))),
                                ),
                                TextButton(
                                    onPressed: (() {
                                      Navigator.pop(context);
                                    }),
                                    child: const Text(
                                      'Dismiss',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 77, 49, 137)),
                                    ))
                              ],
                            ),
                          )));
                },
              ),
              ListTile(
                iconColor: Colors.black,
                leading: const Icon(Icons.lock_outline),
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'Poppins',
                  ),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: ((context) => SizedBox(
                            width: 0.9 * b,
                            height: 0.8 * h,
                            child: SimpleDialog(
                              title: const Text(
                                'Privacy Policy',
                                softWrap: true,
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5),
                                  child: SizedBox(
                                      height: 0.6 * h,
                                      width: 0.9 * b,
                                      child: SingleChildScrollView(
                                          child: Text(
                                        privacytext(),
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16),
                                      ))),
                                ),
                                TextButton(
                                    onPressed: (() {
                                      Navigator.pop(context);
                                    }),
                                    child: const Text(
                                      'Dismiss',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 77, 49, 137)),
                                    ))
                              ],
                            ),
                          )));
                },
              ),
              ListTile(
                iconColor: Colors.black,
                leading: const Icon(Icons.notes_outlined),
                title: const Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'Poppins',
                  ),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: ((context) => SizedBox(
                            width: 0.9 * b,
                            height: 0.8 * h,
                            child: SimpleDialog(
                              title: const Text(
                                'Terms & Conditions',
                                softWrap: true,
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5),
                                  child: SizedBox(
                                      height: 0.6 * h,
                                      width: 0.9 * b,
                                      child: SingleChildScrollView(
                                          child: Text(
                                        termsandcondText(),
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16),
                                      ))),
                                ),
                                TextButton(
                                    onPressed: (() {
                                      Navigator.pop(context);
                                    }),
                                    child: const Text(
                                      'Dismiss',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 77, 49, 137)),
                                    ))
                              ],
                            ),
                          )));
                },
              ),
              SizedBox(
                height: 0.25 * h,
              ),
              const Center(
                  child: Text(
                'Version 1.0.3',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ))
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 212, 235, 255),
      body: Column(
        children: [
          BlocBuilder<LoadVideosBloc, LoadVideosState>(
            builder: (context, state) {
              List<VideoModel> videoList = state.videoList;
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (_, int index) {
                    final data = videoList[index];
                    var title = data.path.toString().split("/").last;
                    // print(data.path);
                    // print(data.id);
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
                                      if (data.isFavourite == true) {
                                        favouriteButton =
                                            'Remove from favourites';
                                        favouriteicon = const Icon(
                                          Icons.favorite_rounded,
                                          color:
                                              Color.fromARGB(255, 252, 97, 97),
                                        );
                                      } else {
                                        favouriteButton = 'Add to favourites';
                                        favouriteicon = const Icon(
                                          Icons.favorite_outline,
                                          color:
                                              Color.fromARGB(255, 252, 97, 97),
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
                                                          const EdgeInsets.all(
                                                              8),
                                                      onPressed: (() {
                                                        if (data.isFavourite ==
                                                            true) {
                                                          context
                                                              .read<
                                                                  FavouritesBloc>()
                                                              .add(DeleteFromFavourites(
                                                                  id2: data
                                                                      .id!));
                                                          // deleteFromFavourites(
                                                          //     data.id!);
                                                          final videoBox = Hive
                                                              .box<VideoModel>(
                                                                  'video_db');
                                                          VideoModel video =
                                                              videoBox
                                                                  .get(index)!;
                                                          video.isFavourite =
                                                              false;
                                                          videoBox.put(
                                                              index, video);

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
                                                        } else {
                                                          final favouritePath =
                                                              data.path;
                                                          final favouriteVideo =
                                                              FavouriteModel(
                                                                  path:
                                                                      favouritePath,
                                                                  isFavourite:
                                                                      true,
                                                                  id: data.id);
                                                          context
                                                              .read<
                                                                  FavouritesBloc>()
                                                              .add(AddToFavourite(
                                                                  value:
                                                                      favouriteVideo));
                                                          context
                                                              .read<
                                                                  FavouritesBloc>()
                                                              .add(
                                                                  GetAllFavourites());
                                                          // addToFavourite(
                                                          //     favouriteVideo);
                                                          final videoBox = Hive
                                                              .box<VideoModel>(
                                                                  'video_db');
                                                          VideoModel video =
                                                              videoBox
                                                                  .get(index)!;
                                                          video.isFavourite =
                                                              true;
                                                          videoBox.put(
                                                              index, video);
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
                                                        }
                                                      }),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              212, 235, 255),
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
                                                                    color: Color
                                                                        .fromARGB(
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
                                                                            return BlocBuilder<PlaylistBloc,
                                                                                PlaylistState>(
                                                                              builder: (context, state) {
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
                                                                          },
                                                                        );
                                                                      }),
                                                                      itemCount:
                                                                          playList
                                                                              .length,
                                                                    ));
                                                                  },
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
        print('this video is already in the playlist');
        return;
      }
    }
    context.read<PlaylistVideoBloc>().add(AddToPlaylist(value: model));
    // addtoPlaylist(model);
    Navigator.pop(context);
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

  String privacytext() {
    return 'Introduction : \n This privacy policy outlines how our video player app collects, uses, and protects personal information provided by users. We take the privacy of our users seriously and strive to ensure that their personal information is protected.\n\n Data Collected :\n Our video player app does not collect any personal information from users unless explicitly provided.\nUse of Data \nWe use the collected data to:\na. Provide and maintain our video player app.\nb. Improve and optimize the app performance.\nc. Personalize the app experience based on user preferences.\nd. Communicate with users, including sending updates and notifications about the app.\ne. Respond to user inquiries and support requests.\nf. Protect the security and integrity of the app and its users.\n\nData Sharing :\nWe do not share or sell user data to any third parties, except when required by law or in response to a valid legal request.\n\nData Security :\nWe take appropriate technical and organizational measures to protect user data from unauthorized access, disclosure, alteration, or destruction. However, no data transmission over the internet or electronic storage system can be guaranteed to be 100% secure.\n\nChanges to Privacy Policy :\nWe reserve the right to modify this privacy policy at any time. If we make any material changes, we will notify users by email or through the app.\n\nContact Information :\nIf you have any questions or concerns about our privacy policy, please contact us at [insert contact information].';
  }

  String aboutUsText() {
    return 'Dhekho app is an application that allows users to watch videos on their mobile devices. It supports various video formats, including MP4, AVI, and MKV, and can play videos stored on the device. The app typically provides features such as playback controls, favourites and playlist. Overall, dhekho is a convenient tool for users to watch their favourite videos on-the-go, offering a range of features to enhance the viewing experience.';
  }

  String termsandcondText() {
    return 'By using this app, you agree to these terms and conditions. The app is provided "as is" and without warranty of any kind. We are not liable for any damages that may arise from your use of the app. You may not use the app for any illegal or unauthorized purpose. You are responsible for any content that you upload or share through the app, and you must have all necessary rights to do so. We reserve the right to terminate your access to the app at any time and for any reason. By using the app, you agree to indemnify and hold us harmless from any claims or damages that may arise from your use of the app.';
  }
}
