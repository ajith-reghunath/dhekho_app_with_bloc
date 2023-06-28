part of 'favourites_bloc.dart';

class FavouritesState {
  final List<FavouriteModel> favouritesList;
  FavouritesState({required this.favouritesList});
}

class FavouritesInitial extends FavouritesState {
  FavouritesInitial({required super.favouritesList});
}
