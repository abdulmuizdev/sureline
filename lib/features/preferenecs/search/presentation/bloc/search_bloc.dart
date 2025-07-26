import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/common/domain/use_cases/favourites/add_favourite_use_case.dart';
import 'package:sureline/common/domain/use_cases/favourites/get_favourites_count_use_case.dart';
import 'package:sureline/common/domain/use_cases/favourites/remove_favourite_use_case.dart';
import 'package:sureline/features/preferenecs/search/domain/use_cases/get_search_use_case.dart';
import 'package:sureline/features/preferenecs/search/presentation/bloc/search_event.dart';
import 'package:sureline/features/preferenecs/search/presentation/bloc/search_state.dart';
import 'package:sureline/core/utils/utils.dart';

/// Bloc for managing search functionality and quote discovery.
///
/// This bloc handles all search-related operations including text input,
/// quote searching, favorite management, and result filtering. It implements
/// debouncing for search queries to optimize performance and provides
/// real-time search results with favorite status integration.
///
/// Key Features:
/// - Real-time search with 500ms debouncing
/// - Favorite quote management (add/remove)
/// - Search result pagination support
/// - Haptic feedback for user interactions
/// - Error handling with Either pattern
///
/// State Management:
/// - Initial: No search performed
/// - SearchingQuotes: Search in progress
/// - SearchedQuotes: Results available
/// - GotSearch: Data loaded successfully
///
/// Event Handling:
/// - OnSearchTextChanged: User input with debouncing
/// - SearchQuote: Execute search operation
/// - OnLikePressed: Toggle favorite status
///
/// Performance Optimizations:
/// - Debounced search to reduce API calls
/// - Efficient state updates
/// - Proper resource disposal
/// - Error recovery mechanisms
///
/// Usage:
/// ```dart
/// BlocProvider(
///   create: (context) => SearchBloc(
///     getSearchUseCase,
///     addFavouriteUseCase,
///     removeFavouriteUseCase,
///     getFavouritesCountUseCase,
///   ),
///   child: SearchWidget(),
/// );
/// ```
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  /// Use case for retrieving search results.
  final GetSearchUseCase _getSearchUseCase;

  /// Use case for adding quotes to favorites.
  final AddFavouriteUseCase _addFavouriteUseCase;

  /// Use case for removing quotes from favorites.
  final RemoveFavouriteUseCase _removeFavouriteUseCase;

  /// Use case for getting favorites count.
  final GetFavouritesCountUseCase _getFavouritesCountUseCase;

  /// Current search query text.
  String searchQuery = '';

  /// Current page number for pagination.
  int page = 1;

  /// Timer for debouncing search input.
  Timer? _debounce;

  /// Creates a new SearchBloc instance.
  SearchBloc(
    this._getSearchUseCase,
    this._addFavouriteUseCase,
    this._removeFavouriteUseCase,
    this._getFavouritesCountUseCase,
  ) : super(const Initial()) {
    on<OnLikePressed>(_onLikePressed);
    on<SearchQuote>(_onSearchQuote);
    on<OnSearchTextChanged>(_onSearchTextChanged);
  }

  /// Handles favorite button press events.
  ///
  /// Toggles the favorite status of a quote and updates the search results.
  /// Provides haptic feedback for user interaction and refreshes the
  /// favorites count after the operation.
  Future<void> _onLikePressed(OnLikePressed event, Emitter<SearchState> emit) async {
    HapticFeedback.lightImpact();
    Either<Failure, int> result;

    if (event.isLiked) {
      // Add quote to favorites
      await _addFavouriteUseCase.call(search: event.entity);
      result = await _getFavouritesCountUseCase.call();
    } else {
      // Remove quote from favorites
      await _removeFavouriteUseCase.call(searchId: event.entity.id);
      result = await _getFavouritesCountUseCase.call();
    }

    result.fold((left) {}, (right) {
      // Refresh search results after favorite change
      add(SearchQuote(searchQuery, page));
    });
  }

  /// Handles search quote events.
  ///
  /// Executes the search operation with the provided query and page number.
  /// Updates the state to reflect the search progress and results.
  Future<void> _onSearchQuote(SearchQuote event, Emitter<SearchState> emit) async {
    await _searchQuote(event.page, event.query, emit);
  }

  /// Handles search text change events with debouncing.
  ///
  /// Implements debouncing to prevent excessive API calls during typing.
  /// Cancels previous timer and starts a new one for each text change.
  void _onSearchTextChanged(OnSearchTextChanged event, Emitter<SearchState> emit) {
    searchQuery = event.query;
    page = event.page;

    // Cancel previous timer if still active
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    // Start new timer for debounced search
    _debounce = Timer(const Duration(milliseconds: 500), () {
      add(SearchQuote(event.query, event.page));
    });
  }

  /// Performs the actual search operation.
  ///
  /// Executes the search use case and updates the state accordingly.
  /// Handles both success and failure cases with proper error handling.
  Future<void> _searchQuote(int searchPage, String query, Emitter<SearchState> emit) async {
    emit(const SearchingQuotes());
    final isPremium = await Utils.checkPremiumStatus();
    final result = await _getSearchUseCase.call(query, isPremium: isPremium);
    result.fold((left) {}, (right) {
      emit(SearchedQuotes(right));
    });
  }
}
