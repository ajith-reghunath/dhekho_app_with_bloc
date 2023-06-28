part of 'favourites_bloc.dart';

class FavouritesEvent {}

class GetAllFavourites extends FavouritesEvent {}

class AddToFavourite extends FavouritesEvent {
  final FavouriteModel value;
  AddToFavourite({required this.value});
}

class DeleteFromFavourites extends FavouritesEvent {
  final int id2;
  DeleteFromFavourites({required this.id2});
}

class DeleteFromFavouritesUsingPath extends FavouritesEvent {
  final String path;
  DeleteFromFavouritesUsingPath({required this.path});
}
