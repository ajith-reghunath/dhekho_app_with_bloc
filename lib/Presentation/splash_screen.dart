import 'dart:async';
import 'package:dhekho_app/Application/LoadVideos/load_videos_bloc.dart';
import 'package:dhekho_app/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const BottomNav()))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadVideosBloc, LoadVideosState>(
      builder: (context, state) {
        context.read<LoadVideosBloc>().add(GetVideos());
        context.read<LoadVideosBloc>().add(LoadVideos());
        return const Scaffold(
          backgroundColor: Color(0xFF362360),
          body: Center(
            child: Text(
              'DHEKHO',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
