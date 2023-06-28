import 'package:dhekho_app/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// ValueNotifier<List<VideoModel>> videoListNotifier = ValueNotifier([]);
class DbFunctions{
List checklist = [];

Future<void> addVideo(VideoModel value) async {
  final videoDB = await Hive.openBox<VideoModel>('video_db');
  if (checklist.contains(value.path)) {
    // print('already added');
  } else {
    final id = await videoDB.add(value);
    value.id = id;
    videoDB.put(id, value);
  }
}

Future<List<VideoModel>> getAllVideos() async {
  final videoDB = await Hive.openBox<VideoModel>('video_db');
  return videoDB.values.toList();
  // videoListNotifier.value.clear();
  // videoListNotifier.value.addAll(videoDB.values);
  // // print(videoDB.values);
  // videoListNotifier.notifyListeners();
  // print('get all videos through notify listeners');
}

Future<void> deleteDatabase() async {
  final videoDB = await Hive.openBox<VideoModel>('video_db');
  await videoDB.clear();
}

Future<void> checkVideo() async {
  final videoDB = await Hive.openBox<VideoModel>('video_db');
  for (var video in videoDB.values) {
    checklist.add(video.path);
  }
}
}

