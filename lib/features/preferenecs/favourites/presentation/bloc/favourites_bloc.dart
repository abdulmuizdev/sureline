import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/use_cases/collections/add_favourite_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_favourite_from_collection_use_case.dart';
import 'package:sureline/features/preferenecs/favourites/domain/use_cases/get_favourites_use_case.dart';
import 'package:sureline/common/domain/use_cases/favourites/remove_favourite_use_case.dart';
import 'package:sureline/features/preferenecs/favourites/presentation/bloc/favourites_event.dart';
import 'package:sureline/features/preferenecs/favourites/presentation/bloc/favourites_state.dart';

/// Bloc for managing favourites-related state and business logic.
///
/// This bloc handles all operations related to user's favourite quotes,
/// including loading favourites, deleting favourites, and managing
/// collection associations. It follows the Clean Architecture pattern
/// by delegating business logic to use cases.
///
/// The bloc maintains the current state of favourites and emits
/// appropriate states based on user actions and data operations.
class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final GetFavouritesUseCase _getFavouritesUseCase;
  final RemoveFavouriteUseCase _removeFavouriteUseCase;

  final AddFavouriteToCollectionUseCase _addFavouriteToCollectionUseCase;
  final RemoveFavouriteFromCollectionUseCase _removeFavouriteFromCollectionUseCase;

  /// Creates a new FavouritesBloc instance.
  ///
  /// [getFavouritesUseCase] - Use case for retrieving favourite quotes
  /// [removeFavouriteUseCase] - Use case for removing quotes from favourites
  /// [addFavouriteToCollectionUseCase] - Use case for adding favourites to collections
  /// [removeFavouriteFromCollectionUseCase] - Use case for removing favourites from collections
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

  /// Retrieves favourite quotes and emits the appropriate state.
  ///
  /// This method calls the get favourites use case and handles the result.
  /// On success, it emits GotFavouriteQuotes with the loaded quotes.
  /// On failure, it maintains the current state (error handling could be
  /// enhanced to emit specific error states).
  ///
  /// [emit] - The emitter for state changes
  Future<void> _getFavouriteQuotes(Emitter<FavouritesState> emit) async {
    final result = await _getFavouritesUseCase.call();
    result.fold((left) {}, (right) {
      emit(GotFavouriteQuotes(right));
    });
  }
}
