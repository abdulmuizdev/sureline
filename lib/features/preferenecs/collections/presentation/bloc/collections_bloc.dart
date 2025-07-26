/// Bloc for collections management.
///
/// Handles state management for collections CRUD operations and quote relationships.
/// This bloc orchestrates all collections-related operations, including creating,
/// deleting, and managing quote relationships across different quote types.
/// It coordinates multiple use cases to provide a unified interface for
/// collections management.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/entities/collections/collection_entity.dart';
import 'package:sureline/common/domain/entities/collections/favourite_entity.dart';
import 'package:sureline/common/domain/entities/collections/history_entity.dart';
import 'package:sureline/common/domain/entities/collections/own_quote_entity.dart';
import 'package:sureline/common/domain/entities/collections/search_entity.dart';
import 'package:sureline/common/domain/use_cases/collections/add_favourite_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/add_history_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/add_own_quote_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/add_search_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_favourite_from_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_history_from_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_own_quote_from_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_search_from_collection_use_case.dart';
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

/// Bloc for managing collections and their relationships.
///
/// This bloc handles all collections-related operations including CRUD operations
/// for collections and managing relationships between collections and different
/// types of quotes (favourites, own quotes, history, search). It coordinates
/// multiple use cases to provide a unified interface for collections management.
///
/// Key responsibilities:
/// - Managing collections lifecycle (create, read, delete)
/// - Handling quote-collection relationships across all quote types
/// - Coordinating complex operations involving multiple quote types
/// - Maintaining state consistency across operations
/// - Providing error handling and state management
class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  /// Use case for retrieving all collections.
  final GetCollectionsUseCase _getCollectionsUseCase;

  /// Use case for saving new collections.
  final SaveCollectionUseCase _saveCollectionUseCase;

  /// Use case for removing collections.
  final RemoveCollectionUseCase _removeCollectionUseCase;

  /// Use case for removing favourites from collections.
  final RemoveFavouriteFromCollectionUseCase _removeFavouriteFromCollectionUseCase;

  /// Use case for removing own quotes from collections.
  final RemoveOwnQuoteFromCollectionUseCase _removeOwnQuoteFromCollectionUseCase;

  /// Use case for adding favourites to collections.
  final AddFavouriteToCollectionUseCase _addFavouriteToCollectionUseCase;

  /// Use case for getting favourites in a collection.
  final GetFavouritesOfCollectionUseCase _getFavouritesOfCollectionUseCase;

  /// Use case for getting collections containing a favourite.
  final GetCollectionsOfFavouritesUseCase _getCollectionsOfFavouritesUseCase;

  /// Use case for adding own quotes to collections.
  final AddOwnQuoteToCollectionUseCase _addOwnQuoteToCollectionUseCase;

  /// Use case for getting own quotes in a collection.
  final GetOwnQuotesOfCollectionUseCase _getOwnQuotesOfCollectionUseCase;

  /// Use case for getting collections containing an own quote.
  final GetCollectionsOfOwnQuotesUseCase _getCollectionsOfOwnQuotesUseCase;

  /// Use case for adding history to collections.
  final AddHistoryToCollectionUseCase _addHistoryToCollectionUseCase;

  /// Use case for removing history from collections.
  final RemoveHistoryFromCollectionUseCase _removeHistoryFromCollectionUseCase;

  /// Use case for getting history in a collection.
  final GetHistoryOfCollectionUseCase _getHistoryOfCollectionUseCase;

  /// Use case for getting collections containing history.
  final GetCollectionsOfHistoryUseCase _getCollectionsOfHistoryUseCase;

  /// Use case for adding search to collections.
  final AddSearchToCollectionUseCase _addSearchToCollectionUseCase;

  /// Use case for removing search from collections.
  final RemoveSearchFromCollectionUseCase _removeSearchFromCollectionUseCase;

  /// Use case for getting search in a collection.
  final GetSearchOfCollectionUseCase _getSearchOfCollectionUseCase;

  /// Use case for getting collections containing search.
  final GetCollectionsOfSearchUseCase _getCollectionsOfSearchUseCase;

  /// Creates a new collections bloc with all required use cases.
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
          final updatedCollectionsResult = await _getCollectionsUseCase.execute();
          updatedCollectionsResult.fold(
            (left) {
              print('Failed to fetch updated collections');
            },
            (right) {
              print('Emitting SavedCollection state with ${right.length} collections');
              emit(SavedCollection(right));
              emit(GotCollections(right)); // Emit GotCollections for list page rebuild
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

      if (event.favouriteId != null && event.ownQuoteId == null && event.quoteId == null) {
        print('Condition 1: Adding favourite to collection');
        await _addFavouriteToCollection(emit, event);
      } else if (event.ownQuoteId != null && event.favouriteId == null && event.quoteId == null) {
        print('Condition 2: Adding own quote to collection');
        await _addOwnQuoteToCollection(emit, event);
      } else if (event.favouriteId != null && event.ownQuoteId != null && event.quoteId == null) {
        print('Condition 3: Adding own quote to collection (favourite and own quote both present)');
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

  /// Handles adding or removing favourite quotes from collections.
  ///
  /// Determines whether to add or remove a favourite quote based on the
  /// selection state and updates the UI accordingly.
  ///
  /// [emit]: The state emitter
  /// [event]: The add to collection event with favourite data
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

  /// Handles adding or removing own quotes from collections.
  ///
  /// Determines whether to add or remove an own quote based on the
  /// selection state and updates the UI accordingly.
  ///
  /// [emit]: The state emitter
  /// [event]: The add to collection event with own quote data
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

  /// Handles adding or removing history quotes from collections.
  ///
  /// Determines whether to add or remove a history quote based on the
  /// selection state and updates the UI accordingly.
  ///
  /// [emit]: The state emitter
  /// [event]: The add to collection event with history data
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

  /// Handles adding or removing search quotes from collections.
  ///
  /// Determines whether to add or remove a search quote based on the
  /// selection state and updates the UI accordingly.
  ///
  /// [emit]: The state emitter
  /// [event]: The add to collection event with search data
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

  /// Retrieves all collections and emits the result.
  ///
  /// Fetches all user collections and emits the appropriate state.
  ///
  /// [emit]: The state emitter
  Future<void> _getCollections(Emitter<CollectionsState> emit) async {
    final result = await _getCollectionsUseCase.execute();
    result.fold(
      (left) {
        // Handle error state
      },
      (right) {
        emit(GotCollections(right));
      },
    );
  }

  /// Retrieves favourites of a collection and emits the result.
  ///
  /// Fetches all favourite quotes in the specified collection.
  ///
  /// [emit]: The state emitter
  /// [collectionId]: The ID of the collection to query
  Future<void> _getFavouritesOfCollection(Emitter<CollectionsState> emit, int collectionId) async {
    final result = await _getFavouritesOfCollectionUseCase.execute(collectionId);
    result.fold(
      (left) {
        // Handle error state
      },
      (right) {
        emit(GotFavouritesOfCollection(right));
      },
    );
  }

  /// Retrieves own quotes of a collection and emits the result.
  ///
  /// Fetches all own quotes in the specified collection.
  ///
  /// [emit]: The state emitter
  /// [collectionId]: The ID of the collection to query
  Future<void> _getOwnQuotesOfCollection(Emitter<CollectionsState> emit, int collectionId) async {
    final result = await _getOwnQuotesOfCollectionUseCase.execute(collectionId);
    result.fold(
      (left) {
        // Handle error state
      },
      (right) {
        emit(GotOwnQuotesOfCollection(right));
      },
    );
  }

  /// Retrieves history quotes of a collection and emits the result.
  ///
  /// Fetches all history quotes in the specified collection.
  ///
  /// [emit]: The state emitter
  /// [collectionId]: The ID of the collection to query
  Future<void> _getHistoryOfCollection(Emitter<CollectionsState> emit, int collectionId) async {
    final result = await _getHistoryOfCollectionUseCase.execute(collectionId);
    result.fold(
      (left) {
        // Handle error state
      },
      (right) {
        emit(GotHistoryOfCollection(right));
      },
    );
  }

  /// Retrieves search quotes of a collection and emits the result.
  ///
  /// Fetches all search quotes in the specified collection.
  ///
  /// [emit]: The state emitter
  /// [collectionId]: The ID of the collection to query
  Future<void> _getSearchOfCollection(Emitter<CollectionsState> emit, int collectionId) async {
    final result = await _getSearchOfCollectionUseCase.execute(collectionId, isPremium: false);
    result.fold(
      (left) {
        // Handle error state
      },
      (right) {
        emit(GotSearchOfCollection(right));
      },
    );
  }

  /// Retrieves collections containing a favourite and emits the result.
  ///
  /// Fetches all collections that contain the specified favourite quote.
  ///
  /// [emit]: The state emitter
  /// [favouriteId]: The ID of the favourite quote to query
  Future<void> _getCollectionsOfFavourite(Emitter<CollectionsState> emit, int favouriteId) async {
    final result = await _getCollectionsOfFavouritesUseCase(favouriteId);
    result.fold(
      (left) {
        // Handle error state
      },
      (right) {
        emit(GotCollectionsOfFavourite(right));
      },
    );
  }

  /// Retrieves collections containing an own quote and emits the result.
  ///
  /// Fetches all collections that contain the specified own quote.
  ///
  /// [emit]: The state emitter
  /// [ownQuoteId]: The ID of the own quote to query
  Future<void> _getCollectionsOfOwnQuote(Emitter<CollectionsState> emit, int ownQuoteId) async {
    final result = await _getCollectionsOfOwnQuotesUseCase(ownQuoteId);
    result.fold(
      (left) {
        // Handle error state
      },
      (right) {
        emit(GotCollectionsOfOwnQuote(right));
      },
    );
  }

  /// Retrieves collections containing a history quote and emits the result.
  ///
  /// Fetches all collections that contain the specified history quote.
  ///
  /// [emit]: The state emitter
  /// [quoteId]: The ID of the history quote to query
  Future<void> _getCollectionsOfHistory(Emitter<CollectionsState> emit, int quoteId) async {
    final result = await _getCollectionsOfHistoryUseCase(quoteId);
    result.fold(
      (left) {
        // Handle error state
      },
      (right) {
        emit(GotCollectionsOfHistory(right));
      },
    );
  }

  /// Retrieves collections containing a search quote and emits the result.
  ///
  /// Fetches all collections that contain the specified search quote.
  ///
  /// [emit]: The state emitter
  /// [searchId]: The ID of the search quote to query
  Future<void> _getCollectionsOfSearch(Emitter<CollectionsState> emit, int searchId) async {
    final result = await _getCollectionsOfSearchUseCase(searchId);
    result.fold(
      (left) {
        // Handle error state
      },
      (right) {
        emit(GotCollectionsOfSearch(right));
      },
    );
  }

  /// Retrieves favourites and their collections, then emits combined state.
  ///
  /// Fetches both favourite quotes and the collections they belong to,
  /// then emits a combined state for complex UI scenarios.
  ///
  /// [emit]: The state emitter
  /// [favouriteId]: The ID of the favourite quote
  /// [collectionId]: The ID of the collection
  Future<void> _getFavouritesOfCollectionAndCollectionsOfFavourite(
    Emitter<CollectionsState> emit,
    int favouriteId,
    int collectionId,
  ) async {
    final favouritesResult = await _getFavouritesOfCollectionUseCase.execute(collectionId);
    final collectionsResult = await _getCollectionsOfFavouritesUseCase(favouriteId);

    favouritesResult.fold(
      (left) {
        // Handle error state
      },
      (favourites) {
        collectionsResult.fold(
          (left) {
            // Handle error state
          },
          (collections) {
            emit(GotFavouritesOfCollectionAndCollectionsOfFavourite(favourites, collections));
          },
        );
      },
    );
  }

  /// Retrieves own quotes and their collections, then emits combined state.
  ///
  /// Fetches both own quotes and the collections they belong to,
  /// then emits a combined state for complex UI scenarios.
  ///
  /// [emit]: The state emitter
  /// [ownQuoteId]: The ID of the own quote
  /// [collectionId]: The ID of the collection
  Future<void> _getOwnQuotesOfCollectionAndCollectionsOfOwnQuote(
    Emitter<CollectionsState> emit,
    int ownQuoteId,
    int collectionId,
  ) async {
    final ownQuotesResult = await _getOwnQuotesOfCollectionUseCase.execute(collectionId);
    final collectionsResult = await _getCollectionsOfOwnQuotesUseCase(ownQuoteId);

    ownQuotesResult.fold(
      (left) {
        // Handle error state
      },
      (ownQuotes) {
        collectionsResult.fold(
          (left) {
            // Handle error state
          },
          (collections) {
            emit(GotOwnQuotesOfCollectionAndCollectionsOfOwnQuote(ownQuotes, collections));
          },
        );
      },
    );
  }

  /// Retrieves history quotes and their collections, then emits combined state.
  ///
  /// Fetches both history quotes and the collections they belong to,
  /// then emits a combined state for complex UI scenarios.
  ///
  /// [emit]: The state emitter
  /// [quoteId]: The ID of the history quote
  /// [collectionId]: The ID of the collection
  Future<void> _getHistoryOfCollectionAndCollectionsOfHistory(
    Emitter<CollectionsState> emit,
    int quoteId,
    int collectionId,
  ) async {
    final historyResult = await _getHistoryOfCollectionUseCase.execute(collectionId);
    final collectionsResult = await _getCollectionsOfHistoryUseCase(quoteId);

    historyResult.fold(
      (left) {
        // Handle error state
      },
      (history) {
        collectionsResult.fold(
          (left) {
            // Handle error state
          },
          (collections) {
            emit(GotHistoryOfCollectionAndCollectionsOfHistory(history, collections));
          },
        );
      },
    );
  }

  /// Retrieves search quotes and their collections, then emits combined state.
  ///
  /// Fetches both search quotes and the collections they belong to,
  /// then emits a combined state for complex UI scenarios.
  ///
  /// [emit]: The state emitter
  /// [searchId]: The ID of the search quote
  /// [collectionId]: The ID of the collection
  Future<void> _getSearchOfCollectionAndCollectionsOfSearch(
    Emitter<CollectionsState> emit,
    int searchId,
    int collectionId,
  ) async {
    final searchResult = await _getSearchOfCollectionUseCase.execute(
      collectionId,
      isPremium: false,
    );
    final collectionsResult = await _getCollectionsOfSearchUseCase(searchId);

    searchResult.fold(
      (left) {
        // Handle error state
      },
      (search) {
        collectionsResult.fold(
          (left) {
            // Handle error state
          },
          (collections) {
            emit(GotSearchOfCollectionAndCollectionsOfSearch(search, collections));
          },
        );
      },
    );
  }
}
