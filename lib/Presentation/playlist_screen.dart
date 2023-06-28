import 'package:dhekho_app/Application/PlaylistVideoBloc/playlist_video_bloc.dart';
import 'package:dhekho_app/Presentation/screen_for_playlist.dart';
import 'package:dhekho_app/Infrastructure/db_playlist.dart';
import 'package:dhekho_app/Application/bloc/playlist_bloc.dart';
import 'package:dhekho_app/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaylistScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _editnameController = TextEditingController();

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
              'Playlists',
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 46, 19, 73),
        onPressed: (() {
          showDialog(
              context: context,
              builder: ((context) {
                return BlocBuilder<PlaylistBloc, PlaylistState>(
                  builder: (context, state) {
                    return SimpleDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: const Text(
                        'Create playlist',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500),
                      ),
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                ),
                                keyboardType: TextInputType.text,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                controller: _titleController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Name is required';
                                  } else if (value.contains('@') ||
                                      value.contains('.')) {
                                    return 'Enter valid Name';
                                  } else {
                                    return null;
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Title',
                                    hintText: 'Title'),
                              ),
                            ),
                            SimpleDialogOption(
                              child: Container(
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromARGB(255, 48, 48, 48),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: const Center(
                                  child: Text(
                                    'ADD',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                final title = _titleController.text.trim();
                                if (title.isEmpty) {
                                  return;
                                }
                                final playlist = PlaylistModel(name: title);
                                context
                                    .read<PlaylistBloc>()
                                    .add(AddPlaylist(playlist: playlist));
                                context
                                    .read<PlaylistBloc>()
                                    .add(DisplayPlaylist());
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 38, 38, 38),
                                    content: Text(
                                      'New playlist created successfully',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 254, 253, 255),
                                        fontSize: 0.045 * b,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    duration: const Duration(seconds: 3),
                                  ),
                                );
                              },
                            )
                          ],
                        )
                      ],
                    );
                  },
                );
              }));
        }),
        label: const Text('Create Playlist',
            style: TextStyle(
                fontSize: 20,
                letterSpacing: 0.5,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400)),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color.fromARGB(255, 212, 235, 255),
      body: SafeArea(child: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          // context.read<PlaylistBloc>().add(DisplayPlaylist());
          print('fffffffffffffff${state.playlist}');
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              children: List.generate(state.playlist.length, (index) {
                final data = state.playlist[index];
                // print('dsddddddddd');
                // print('${data.name} & ${data.playlistId}');

                return BlocBuilder<PlaylistVideoBloc, PlaylistVideoState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<PlaylistVideoBloc>()
                            .add(GetAllPlaylistVideo());
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ScreenForPlaylist(
                            name: data.name,
                            playlistID: data.playlistId!,
                          );
                        }));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: const Color.fromARGB(255, 250, 250, 250),
                        elevation: 3,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 0.08 * b),
                                const Image(
                                  image:
                                      AssetImage('assets/images/playlist.png'),
                                  width: 150,
                                ),
                                SizedBox(height: 0.02 * b),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          data.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              letterSpacing: 0.5,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return SimpleDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  title: const Text(
                                                    'Choose one',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  children: [
                                                    //delete playlist//
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        showModalBottomSheet(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            context: context,
                                                            builder: (context) {
                                                              return SizedBox(
                                                                height: 0.2 * h,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(25),
                                                                  child: Column(
                                                                    children: [
                                                                      Text(
                                                                        'Do you want to delete this playlist?',
                                                                        style: TextStyle(
                                                                            fontSize: 0.05 *
                                                                                b,
                                                                            fontFamily:
                                                                                'Poppins'),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              0.02 * h),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 212, 235, 255)),
                                                                              onPressed: () {
                                                                                context.read<PlaylistBloc>().add(DeletePlaylist(index: data.playlistId!));
                                                                                context.read<PlaylistBloc>().add(DisplayPlaylist());
                                                                                // deletePlaylist(data.playlistId!);
                                                                                Navigator.pop(context);
                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                  SnackBar(
                                                                                    backgroundColor: const Color.fromARGB(255, 38, 38, 38),
                                                                                    content: Text(
                                                                                      '${data.name} has been deleted successfully',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(
                                                                                        color: const Color.fromARGB(255, 254, 253, 255),
                                                                                        fontSize: 0.045 * b,
                                                                                        fontFamily: 'Poppins',
                                                                                      ),
                                                                                    ),
                                                                                    duration: const Duration(seconds: 3),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: Container(
                                                                                color: const Color.fromARGB(255, 212, 235, 255),
                                                                                width: 80,
                                                                                child: const Center(
                                                                                  child: Text(
                                                                                    'Yes',
                                                                                    style: TextStyle(color: Color.fromARGB(255, 26, 26, 26), fontSize: 20, fontFamily: 'Poppins'),
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                          ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 212, 235, 255)),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: Container(
                                                                                color: const Color.fromARGB(255, 212, 235, 255),
                                                                                width: 80,
                                                                                child: const Center(
                                                                                  child: Text(
                                                                                    'No',
                                                                                    style: TextStyle(color: Color.fromARGB(255, 26, 26, 26), fontSize: 20, fontFamily: 'Poppins'),
                                                                                  ),
                                                                                ),
                                                                              ))
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
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
                                                        child: const Center(
                                                          child: Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        26,
                                                                        26,
                                                                        26),
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    //rename playlist//
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        _editnameController
                                                            .text = data.name;
                                                        showModalBottomSheet(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            context: context,
                                                            isScrollControlled:
                                                                true,
                                                            builder: (context) {
                                                              return Padding(
                                                                padding: EdgeInsets.only(
                                                                    bottom: MediaQuery.of(
                                                                            context)
                                                                        .viewInsets
                                                                        .bottom),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20,
                                                                          top:
                                                                              20),
                                                                      child:
                                                                          Text(
                                                                        'Rename playlist',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                22,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontFamily: 'Poppins'),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              20),
                                                                      child:
                                                                          TextFormField(
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                        ),
                                                                        keyboardType:
                                                                            TextInputType.text,
                                                                        textCapitalization:
                                                                            TextCapitalization.sentences,
                                                                        controller:
                                                                            _editnameController,
                                                                        validator:
                                                                            (value) {
                                                                          if (value!
                                                                              .isEmpty) {
                                                                            return 'Name is required';
                                                                          } else if (value.contains('@') ||
                                                                              value.contains('.')) {
                                                                            return 'Enter valid Name';
                                                                          } else {
                                                                            return null;
                                                                          }
                                                                        },
                                                                        autovalidateMode:
                                                                            AutovalidateMode.onUserInteraction,
                                                                        decoration: InputDecoration(
                                                                            border: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            labelText: 'Title',
                                                                            hintText: 'Title'),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          bottom:
                                                                              20),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 212, 235, 255)),
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Container(
                                                                                color: const Color.fromARGB(255, 212, 235, 255),
                                                                                width: 0.2 * b,
                                                                                child: const Center(
                                                                                  child: Text(
                                                                                    'Cancel',
                                                                                    style: TextStyle(color: Color.fromARGB(255, 26, 26, 26), fontSize: 20, fontFamily: 'Poppins'),
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                          ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 212, 235, 255)),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                                playlistUpdate(data.playlistId!);
                                                                              },
                                                                              child: Container(
                                                                                color: const Color.fromARGB(255, 212, 235, 255),
                                                                                width: 0.25 * b,
                                                                                child: const Center(
                                                                                  child: Text(
                                                                                    'Rename',
                                                                                    style: TextStyle(color: Color.fromARGB(255, 26, 26, 26), fontSize: 20, fontFamily: 'Poppins'),
                                                                                  ),
                                                                                ),
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
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
                                                        child: const Center(
                                                          child: Text(
                                                            'Rename',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        26,
                                                                        26,
                                                                        26),
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              });
                                        },
                                        icon: const Icon(
                                          Icons.more_vert,
                                          color:
                                              Color.fromARGB(255, 54, 54, 54),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          );
        },
      )),
    );
  }

  Future<void> onAddButton() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      return;
    }
    final playlist = PlaylistModel(name: title);

    // await addPlaylist(playlist);
  }

  Future<void> playlistUpdate(int id) async {
    final name = _editnameController.text.trim();
    final playlist = PlaylistModel(name: name, playlistId: id);
    // await updatePlaylist(playlist);
  }
}
