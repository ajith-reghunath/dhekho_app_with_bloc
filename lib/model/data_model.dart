import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class VideoModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final path;
  @HiveField(2)
  bool? isFavourite;
  VideoModel({this.id, this.path, this.isFavourite = false});
}

@HiveType(typeId: 2)
class FavouriteModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final path;
  @HiveField(2)
  bool? isFavourite;
  FavouriteModel({this.id, required this.path, this.isFavourite = true});
}

@HiveType(typeId: 3)
class PlaylistModel {
  @HiveField(0)
  int? playlistId;
  @HiveField(1)
  String name;
  PlaylistModel({required this.name, this.playlistId});
}

@HiveType(typeId: 4)
class PlaylistVideoModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final path;
  @HiveField(2)
  int? playlistId;
  @HiveField(3)
  bool? isFavourite;
  @HiveField(4)
  String? name;
  PlaylistVideoModel({this.playlistId, required this.path, this.id, this.isFavourite=false, this.name});
}
