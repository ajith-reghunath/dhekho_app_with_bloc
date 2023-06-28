import 'package:bloc/bloc.dart';
import 'package:dhekho_app/Infrastructure/db_favourite.dart';
import 'package:meta/meta.dart';

import '../../model/data_model.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial(favouritesList: [])) {
    final DbFavourite favouriteDbFunctions = DbFavourite();
    on<GetAllFavourites>((event, emit) async {
      final result = await favouriteDbFunctions.getAllFavourites();
      emit(FavouritesState(favouritesList: result));
    });
    on<AddToFavourite>((event, emit) async {
      await favouriteDbFunctions.addToFavourite(event.value);
    });
    on<DeleteFromFavourites>((event, emit) async {
      await favouriteDbFunctions.deleteFromFavourites(event.id2);
    });
    on<DeleteFromFavouritesUsingPath>((event, emit) async {
      await favouriteDbFunctions.deleteFromFavouritesUsingPath(event.path);
    });
  }
}
