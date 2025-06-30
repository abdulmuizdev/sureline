import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/use_cases/collections/add_favourite_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/add_own_quote_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_favourite_from_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_own_quote_from_collection_use_case.dart';
import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/collections/domain/use_cases/get_collections_of_favourites_use_case.dart';
import 'package:sureline/features/collections/domain/use_cases/get_collections_of_own_quotes_use_case.dart';
import 'package:sureline/features/collections/domain/use_cases/get_collections_use_case.dart';
import 'package:sureline/features/collections/domain/use_cases/get_favourites_of_collection_use_case.dart';
import 'package:sureline/features/collections/domain/use_cases/get_own_quotes_of_collection_use_case.dart';
import 'package:sureline/features/collections/domain/use_cases/remove_collection_use_case.dart';
import 'package:sureline/features/collections/domain/use_cases/save_collection_use_case.dart';
import 'package:sureline/features/collections/presentation/bloc/collections_event.dart';
import 'package:sureline/features/collections/presentation/bloc/collections_state.dart';
import 'package:sureline/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  final GetCollectionsUseCase _getCollectionsUseCase;
  final SaveCollectionUseCase _saveCollectionUseCase;
  final RemoveCollectionUseCase _removeCollectionUseCase;
  final RemoveFavouriteFromCollectionUseCase
  _removeFavouriteFromCollectionUseCase;
  final RemoveOwnQuoteFromCollectionUseCase
  _removeOwnQuoteFromCollectionUseCase;

  final AddFavouriteToCollectionUseCase _addFavouriteToCollectionUseCase;
  final GetFavouritesOfCollectionUseCase _getFavouritesOfCollectionUseCase;
  final GetCollectionsOfFavouritesUseCase _getCollectionsOfFavouritesUseCase;

  final AddOwnQuoteToCollectionUseCase _addOwnQuoteToCollectionUseCase;
  final GetOwnQuotesOfCollectionUseCase _getOwnQuotesOfCollectionUseCase;
  final GetCollectionsOfOwnQuotesUseCase _getCollectionsOfOwnQuotesUseCase;

  CollectionsBloc(
    this._getCollectionsUseCase,
    this._removeCollectionUseCase,
    this._saveCollectionUseCase,
    this._removeFavouriteFromCollectionUseCase,
    this._removeOwnQuoteFromCollectionUseCase,
    this._getFavouritesOfCollectionUseCase,
    this._addFavouriteToCollectionUseCase,
    this._getCollectionsOfFavouritesUseCase,
    this._addOwnQuoteToCollectionUseCase,
    this._getOwnQuotesOfCollectionUseCase,
    this._getCollectionsOfOwnQuotesUseCase,
  ) : super(Initial()) {
    on<GetCollections>((event, emit) async {
      await _getCollections(emit);
    });

    on<OnDeletePressed>((event, emit) async {
      final result1 = await _removeCollectionUseCase.execute(event.entity);
      await result1.fold((left) {}, (right) async {
        await _getCollections(emit);
      });
    });

    on<SaveCollection>((event, emit) async {
      final result = await _saveCollectionUseCase.execute(event.entity);
      await result.fold((_) {}, (_) async {
        final updatedCollectionsResult = await _getCollectionsUseCase.execute();
        updatedCollectionsResult.fold((left) {}, (right) {
          emit(SavedCollection(right));
        });
      });
    });

    on<OnDeleteQuotePressed>((event, emit) async {
      final result = await _removeFavouriteFromCollectionUseCase.execute(
        event.collectionId,
        event.favouriteId,
      );
      await result.fold((left) {}, (right) async {
        await _getFavouritesOfCollection(emit, event.collectionId);
      });
    });

    on<OnAddToCollectionPressed>((event, emit) async {
      print('event.favouriteId: ${event.favouriteId}');
      print('event.ownQuoteId: ${event.ownQuoteId}');
      if (event.favouriteId != null) {
        if (!event.isSelected) {
          final result = await _removeFavouriteFromCollectionUseCase.execute(
            event.collectionId,
            event.favouriteId!,
          );
          await result.fold((left) {}, (right) async {
            await _getFavouritesOfCollectionAndCollectionsOfFavourite(
              emit,
              event.favouriteId!,
              event.collectionId,
            );
          });
        } else {
          final result = await _addFavouriteToCollectionUseCase.execute(
            event.collectionId,
            event.favouriteId!,
          );
          await result.fold((left) {}, (right) async {
            await _getFavouritesOfCollectionAndCollectionsOfFavourite(
              emit,
              event.favouriteId!,
              event.collectionId,
            );
          });
        }
      } else if (event.ownQuoteId != null) {
        if (!event.isSelected) {
          final result = await _removeOwnQuoteFromCollectionUseCase.execute(
            event.collectionId,
            event.ownQuoteId!,
          );
          await result.fold((left) {}, (right) async {
            await _getOwnQuotesOfCollectionAndCollectionsOfOwnQuote(
              emit,
              event.ownQuoteId!,
              event.collectionId,
            );
          });
        } else {
          final result = await _addOwnQuoteToCollectionUseCase.execute(
            event.collectionId,
            event.ownQuoteId!,
          );
          await result.fold((left) {}, (right) async {
            await _getOwnQuotesOfCollectionAndCollectionsOfOwnQuote(
              emit,
              event.ownQuoteId!,
              event.collectionId,
            );
          });
        }
      }
    });

    on<GetFavouritesOfCollection>((event, emit) async {
      await _getFavouritesOfCollection(emit, event.id);
    });

    on<GetOwnQuotesOfCollection>((event, emit) async {
      await _getOwnQuotesOfCollection(emit, event.id);
    });

    on<GetCollectionsOfFavourite>((event, emit) async {
      await _getCollectionsOfFavourite(emit, event.favouriteId);
    });

    on<GetCollectionsOfOwnQuote>((event, emit) async {
      await _getCollectionsOfOwnQuote(emit, event.ownQuoteId);
    });
  }

  Future<void> _getCollections(Emitter<CollectionsState> emit) async {
    final result = await _getCollectionsUseCase.execute();
    result.fold((left) {}, (right) {
      emit(GotCollections(right));
    });
  }

  Future<void> _getFavouritesOfCollection(
    Emitter<CollectionsState> emit,
    id,
  ) async {
    final result = await _getFavouritesOfCollectionUseCase.execute(id);
    result.fold((left) {}, (right) {
      emit(GotFavouritesOfCollection(right));
    });
  }

  Future<void> _getOwnQuotesOfCollection(
    Emitter<CollectionsState> emit,
    id,
  ) async {
    final result = await _getOwnQuotesOfCollectionUseCase.execute(id);
    result.fold((left) {}, (right) {
      emit(GotOwnQuotesOfCollection(right));
    });
  }

  Future<void> _getCollectionsOfFavourite(
    Emitter<CollectionsState> emit,
    int favouriteId,
  ) async {
    final result = await _getCollectionsOfFavouritesUseCase.call(favouriteId);
    result.fold((left) {}, (right) {
      emit(GotCollectionsOfFavourite(right));
    });
  }

  Future<void> _getCollectionsOfOwnQuote(
    Emitter<CollectionsState> emit,
    int ownQuoteId,
  ) async {
    final result = await _getCollectionsOfOwnQuotesUseCase.call(ownQuoteId);
    result.fold((left) {}, (right) {
      emit(GotCollectionsOfOwnQuote(right));
    });
  }

  Future<void> _getFavouritesOfCollectionAndCollectionsOfFavourite(
    Emitter<CollectionsState> emit,
    int favouriteId,
    int collectionId,
  ) async {
    List<FavouriteEntity> favourites = [];
    List<CollectionEntity> collections = [];
    final result = await _getFavouritesOfCollectionUseCase.execute(
      collectionId,
    );
    result.fold((left) {}, (right) {
      favourites = right;
    });
    final result2 = await _getCollectionsOfFavouritesUseCase.call(favouriteId);
    result2.fold((left) {}, (right) {
      collections = right;
    });
    emit(
      GotFavouritesOfCollectionAndCollectionsOfFavourite(
        favourites,
        collections,
      ),
    );
  }

  Future<void> _getOwnQuotesOfCollectionAndCollectionsOfOwnQuote(
    Emitter<CollectionsState> emit,
    int ownQuoteId,
    int collectionId,
  ) async {
    List<OwnQuoteEntity> ownQuotes = [];
    List<CollectionEntity> collections = [];
    final result = await _getOwnQuotesOfCollectionUseCase.execute(collectionId);
    result.fold((left) {}, (right) {
      ownQuotes = right;
    });
    final result2 = await _getCollectionsOfOwnQuotesUseCase.call(ownQuoteId);
    result2.fold((left) {}, (right) {
      collections = right;
    });
    emit(
      GotOwnQuotesOfCollectionAndCollectionsOfOwnQuote(ownQuotes, collections),
    );
  }
}
