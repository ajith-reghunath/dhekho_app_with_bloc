import 'package:dhekho_app/Application/FavouritesBloc/favourites_bloc.dart';
import 'package:dhekho_app/Application/LoadVideos/load_videos_bloc.dart';
import 'package:dhekho_app/Presentation/favourite_screen.dart';
import 'package:dhekho_app/Presentation/homepage.dart';
import 'package:dhekho_app/Presentation/playlist_screen.dart';
import 'package:dhekho_app/Presentation/search_screen.dart';
import 'package:dhekho_app/Application/bloc/playlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  void _navigateBottomBar(int index) {
    switch (index) {
      case 0:
        context.read<LoadVideosBloc>().add(LoadVideos());
        break;
      case 1:
        print('search');
        break;
      case 2:
        context.read<FavouritesBloc>().add(GetAllFavourites());
        break;
      case 3:
        context.read<PlaylistBloc>().add(DisplayPlaylist());
        break;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const SearchScreen(),
    const FavouriteScreen(),
    PlaylistScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
        return BlocBuilder<FavouritesBloc, FavouritesState>(
          builder: (context, state) {
            return BlocBuilder<LoadVideosBloc, LoadVideosState>(
              builder: (context, state) {
                return Scaffold(
                  body: _pages[_selectedIndex],
                  bottomNavigationBar: Container(
                    color: const Color(0xFF362360),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: GNav(
                          padding: const EdgeInsets.all(14),
                          iconSize: 25,
                          textStyle: const TextStyle(
                              fontSize: 18, color: Colors.white),
                          gap: 8,
                          backgroundColor: const Color(0xFF362360),
                          color: Colors.white,
                          activeColor: Colors.white,
                          tabBackgroundColor:
                              const Color.fromARGB(255, 77, 49, 137),
                          tabs: const [
                            GButton(
                              icon: Icons.home,
                              text: 'Home',
                            ),
                            GButton(
                              icon: Icons.search,
                              text: 'Search',
                            ),
                            GButton(
                              icon: Icons.favorite,
                              text: 'Favourites',
                            ),
                            GButton(
                              icon: Icons.playlist_add,
                              text: 'Playlist',
                            )
                          ],
                          onTabChange: _navigateBottomBar),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
