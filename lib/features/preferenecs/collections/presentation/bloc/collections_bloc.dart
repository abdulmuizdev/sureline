import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/use_cases/collections/add_favourite_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/add_history_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/add_own_quote_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/add_search_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_favourite_from_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_history_from_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_own_quote_from_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_search_from_collection_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_collections_of_favourites_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_collections_of_history_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_collections_of_own_quotes_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_collections_of_search_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_collections_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_favourites_of_collection_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_history_of_collection_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_own_quotes_of_collection_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_search_of_collection_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/remove_collection_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/save_collection_use_case.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_event.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_state.dart';
import 'package:sureline/features/preferenecs/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/preferenecs/history/domain/entity/history_entity.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/preferenecs/search/domain/entity/search_entity.dart';

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

  final AddHistoryToCollectionUseCase _addHistoryToCollectionUseCase;
  final RemoveHistoryFromCollectionUseCase _removeHistoryFromCollectionUseCase;
  final GetHistoryOfCollectionUseCase _getHistoryOfCollectionUseCase;
  final GetCollectionsOfHistoryUseCase _getCollectionsOfHistoryUseCase;

  final AddSearchToCollectionUseCase _addSearchToCollectionUseCase;
  final RemoveSearchFromCollectionUseCase _removeSearchFromCollectionUseCase;
  final GetSearchOfCollectionUseCase _getSearchOfCollectionUseCase;
  final GetCollectionsOfSearchUseCase _getCollectionsOfSearchUseCase;

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
    this._addHistoryToCollectionUseCase,
    this._removeHistoryFromCollectionUseCase,
    this._getHistoryOfCollectionUseCase,
    this._getCollectionsOfHistoryUseCase,
    this._addSearchToCollectionUseCase,
    this._removeSearchFromCollectionUseCase,
    this._getSearchOfCollectionUseCase,
    this._getCollectionsOfSearchUseCase,
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
      print('SaveCollection event triggered with name: ${event.entity.name}');
      final result = await _saveCollectionUseCase.execute(event.entity);
      await result.fold(
        (_) {
          print('SaveCollection failed');
        },
        (_) async {
          print('SaveCollection succeeded, fetching updated collections');
          final updatedCollectionsResult =
              await _getCollectionsUseCase.execute();
          updatedCollectionsResult.fold(
            (left) {
              print('Failed to fetch updated collections');
            },
            (right) {
              print(
                'Emitting SavedCollection state with ${right.length} collections',
              );
              emit(SavedCollection(right));
              emit(
                GotCollections(right),
              ); // Emit GotCollections for list page rebuild
            },
          );
        },
      );
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
      print('event.quoteId: ${event.quoteId}');
      print('event.searchId: ${event.searchId}');

      if (event.favouriteId != null &&
          event.ownQuoteId == null &&
          event.quoteId == null) {
        print('Condition 1: Adding favourite to collection');
        await _addFavouriteToCollection(emit, event);
      } else if (event.ownQuoteId != null &&
          event.favouriteId == null &&
          event.quoteId == null) {
        print('Condition 2: Adding own quote to collection');
        await _addOwnQuoteToCollection(emit, event);
      } else if (event.favouriteId != null &&
          event.ownQuoteId != null &&
          event.quoteId == null) {
        print(
          'Condition 3: Adding own quote to collection (favourite and own quote both present)',
        );
        await _addOwnQuoteToCollection(emit, event);
      } else if (event.quoteId != null &&
          // event.favouriteId == null &&
          event.ownQuoteId == null) {
        print('Condition 4: Adding history to collection');
        await _addHistoryToCollection(emit, event);
      } else if (event.searchId != null &&
          event.favouriteId == null &&
          event.ownQuoteId == null &&
          event.quoteId == null) {
        print('Condition 5: Adding search to collection');
        await _addSearchToCollection(emit, event);
      }
    });

    on<GetFavouritesOfCollection>((event, emit) async {
      await _getFavouritesOfCollection(emit, event.id);
    });

    on<GetOwnQuotesOfCollection>((event, emit) async {
      await _getOwnQuotesOfCollection(emit, event.id);
    });

    on<GetHistoryOfCollection>((event, emit) async {
      await _getHistoryOfCollection(emit, event.collectionId);
    });

    on<GetSearchOfCollection>((event, emit) async {
      await _getSearchOfCollection(emit, event.collectionId);
    });

    on<GetCollectionsOfFavourite>((event, emit) async {
      await _getCollectionsOfFavourite(emit, event.favouriteId);
    });

    on<GetCollectionsOfOwnQuote>((event, emit) async {
      await _getCollectionsOfOwnQuote(emit, event.ownQuoteId);
    });

    on<GetCollectionsOfHistory>((event, emit) async {
      await _getCollectionsOfHistory(emit, event.quoteId);
    });

    on<GetCollectionsOfSearch>((event, emit) async {
      await _getCollectionsOfSearch(emit, event.searchId);
    });
  }

  Future<void> _addFavouriteToCollection(
    Emitter<CollectionsState> emit,
    OnAddToCollectionPressed event,
  ) async {
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
  }

  Future<void> _addOwnQuoteToCollection(
    Emitter<CollectionsState> emit,
    OnAddToCollectionPressed event,
  ) async {
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

  Future<void> _addHistoryToCollection(
    Emitter<CollectionsState> emit,
    OnAddToCollectionPressed event,
  ) async {
    if (!event.isSelected) {
      final result = await _removeHistoryFromCollectionUseCase.execute(
        event.collectionId,
        event.quoteId!,
      );
      await result.fold((left) {}, (right) async {
        await _getHistoryOfCollectionAndCollectionsOfHistory(
          emit,
          event.quoteId!,
          event.collectionId,
        );
      });
    } else {
      final result = await _addHistoryToCollectionUseCase.execute(
        event.collectionId,
        event.quoteId!,
      );
      await result.fold((left) {}, (right) async {
        await _getHistoryOfCollectionAndCollectionsOfHistory(
          emit,
          event.quoteId!,
          event.collectionId,
        );
      });
    }
  }

  Future<void> _addSearchToCollection(
    Emitter<CollectionsState> emit,
    OnAddToCollectionPressed event,
  ) async {
    if (!event.isSelected) {
      final result = await _removeSearchFromCollectionUseCase.execute(
        event.collectionId,
        event.searchId!,
      );
      await result.fold((left) {}, (right) async {
        await _getSearchOfCollectionAndCollectionsOfSearch(
          emit,
          event.searchId!,
          event.collectionId,
        );
      });
    } else {
      final result = await _addSearchToCollectionUseCase.execute(
        event.collectionId,
        event.searchId!,
      );
      await result.fold((left) {}, (right) async {
        await _getSearchOfCollectionAndCollectionsOfSearch(
          emit,
          event.searchId!,
          event.collectionId,
        );
      });
    }
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

  Future<void> _getHistoryOfCollection(
    Emitter<CollectionsState> emit,
    int collectionId,
  ) async {
    final result = await _getHistoryOfCollectionUseCase.execute(collectionId);
    result.fold((left) {}, (right) {
      emit(GotHistoryOfCollection(right));
    });
  }

  Future<void> _getSearchOfCollection(
    Emitter<CollectionsState> emit,
    int collectionId,
  ) async {
    final result = await _getSearchOfCollectionUseCase.execute(collectionId);
    result.fold((left) {}, (right) {
      emit(GotSearchOfCollection(right));
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

  Future<void> _getCollectionsOfHistory(
    Emitter<CollectionsState> emit,
    int quoteId,
  ) async {
    final result = await _getCollectionsOfHistoryUseCase.call(quoteId);
    result.fold((left) {}, (right) {
      emit(GotCollectionsOfHistory(right));
    });
  }

  Future<void> _getCollectionsOfSearch(
    Emitter<CollectionsState> emit,
    int searchId,
  ) async {
    final result = await _getCollectionsOfSearchUseCase.call(searchId);
    result.fold((left) {}, (right) {
      emit(GotCollectionsOfSearch(right));
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

  Future<void> _getHistoryOfCollectionAndCollectionsOfHistory(
    Emitter<CollectionsState> emit,
    int historyId,
    int collectionId,
  ) async {
    List<HistoryEntity> history = [];
    List<CollectionEntity> collections = [];
    final result = await _getHistoryOfCollectionUseCase.execute(collectionId);
    result.fold((left) {}, (right) {
      history = right;
    });
    final result2 = await _getCollectionsOfHistoryUseCase.call(historyId);
    result2.fold((left) {}, (right) {
      collections = right;
    });
    emit(GotHistoryOfCollectionAndCollectionsOfHistory(history, collections));
  }

  Future<void> _getSearchOfCollectionAndCollectionsOfSearch(
    Emitter<CollectionsState> emit,
    int searchId,
    int collectionId,
  ) async {
    List<SearchEntity> search = [];
    List<CollectionEntity> collections = [];
    final result = await _getSearchOfCollectionUseCase.execute(collectionId);
    result.fold((left) {}, (right) {
      search = right;
    });
    final result2 = await _getCollectionsOfSearchUseCase.call(searchId);
    result2.fold((left) {}, (right) {
      collections = right;
    });
    emit(GotSearchOfCollectionAndCollectionsOfSearch(search, collections));
  }
}
