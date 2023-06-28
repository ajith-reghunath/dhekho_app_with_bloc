import 'package:dhekho_app/Application/FavouritesBloc/favourites_bloc.dart';
import 'package:dhekho_app/Application/LoadVideos/load_videos_bloc.dart';
import 'package:dhekho_app/Application/PlaylistVideoBloc/playlist_video_bloc.dart';
import 'package:dhekho_app/Presentation/splash_screen.dart';
import 'package:dhekho_app/Application/bloc/playlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/data_model.dart';

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(VideoModelAdapter().typeId)) {
    Hive.registerAdapter(VideoModelAdapter());
  }
  if (!Hive.isAdapterRegistered(FavouriteModelAdapter().typeId)) {
    Hive.registerAdapter(FavouriteModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlaylistModelAdapter().typeId)) {
    Hive.registerAdapter(PlaylistModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlaylistVideoModelAdapter().typeId)) {
    Hive.registerAdapter(PlaylistVideoModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PlaylistBloc()),
        BlocProvider(create: (context) => PlaylistVideoBloc()),
        BlocProvider(create: (context) => FavouritesBloc()),
        BlocProvider(create: ((context) => LoadVideosBloc()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dhekho',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
