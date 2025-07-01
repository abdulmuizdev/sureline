import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/use_cases/collections/add_favourite_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_favourite_from_collection_use_case.dart';
import 'package:sureline/features/favourites/domain/use_cases/get_favourites_use_case.dart';
import 'package:sureline/features/favourites/domain/use_cases/remove_favourite_use_case.dart';
import 'package:sureline/features/favourites/presentation/bloc/favourites_event.dart';
import 'package:sureline/features/favourites/presentation/bloc/favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final GetFavouritesUseCase _getFavouritesUseCase;
  final RemoveFavouriteUseCase _removeFavouriteUseCase;

  final AddFavouriteToCollectionUseCase _addFavouriteToCollectionUseCase;
  final RemoveFavouriteFromCollectionUseCase
  _removeFavouriteFromCollectionUseCase;

  FavouritesBloc(
    this._getFavouritesUseCase,
    this._removeFavouriteUseCase,
    this._addFavouriteToCollectionUseCase,
    this._removeFavouriteFromCollectionUseCase,
  ) : super(Initial()) {
    on<GetFavouriteQuotes>((event, emit) async {
      await _getFavouriteQuotes(emit);
    });

    on<OnDeletePressed>((event, emit) async {
      final result = await _removeFavouriteUseCase.call(
        quoteId: event.entity.quoteId,
        ownQuoteId: event.entity.ownQuoteId,
        searchId: event.entity.searchId,
        historyId: event.entity.historyId,
      );
      await result.fold((left) {}, (right) async {
        await _getFavouriteQuotes(emit);
      });
    });
  }
  Future<void> _getFavouriteQuotes(Emitter<FavouritesState> emit) async {
    final result = await _getFavouritesUseCase.call();
    result.fold((left) {}, (right) {
      emit(GotFavouriteQuotes(right));
    });
  }
}
