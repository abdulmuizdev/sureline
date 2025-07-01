import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/use_cases/quote/get_quotes_search_results_use_case.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/favourites/domain/use_cases/add_favourite_use_case.dart';
import 'package:sureline/features/favourites/domain/use_cases/get_favourites_count_use_case.dart';
import 'package:sureline/features/favourites/domain/use_cases/remove_favourite_use_case.dart';
import 'package:sureline/features/search/domain/use_cases/get_search_use_case.dart';
import 'package:sureline/features/search/presentation/bloc/search_event.dart';
import 'package:sureline/features/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  // final GetQuotesSearchResultsUseCase _getQuotesSearchResultsUseCase;
  final GetSearchUseCase _getSearchUseCase;

  // final GetQuotesUseCase _getQuotesUseCase;

  // final SaveLikedQuoteUseCase _saveLikedQuoteUseCase;
  final AddFavouriteUseCase _addFavouriteUseCase;
  final RemoveFavouriteUseCase _removeFavouriteUseCase;
  final GetFavouritesCountUseCase _getFavouritesCountUseCase;

  String searchQuery = '';
  int page = 1;
  Timer? _debounce;

  SearchBloc(
    this._getSearchUseCase,
    // this._getQuotesUseCase,
    this._addFavouriteUseCase,
    this._removeFavouriteUseCase,
    this._getFavouritesCountUseCase,
  ) : super(Initial()) {
    on<OnLikePressed>((event, emit) async {
      HapticFeedback.lightImpact();
      Either<Failure, int> result;
      if (event.isLiked) {
        await _addFavouriteUseCase.call(search: event.entity);
        result = await _getFavouritesCountUseCase.call();
      } else {
        await _removeFavouriteUseCase.call(searchId: event.entity.id);
        result = await _getFavouritesCountUseCase.call();
      }
      result.fold((left) {}, (right) {
        // emit(GotLikeCount(right));
        add(SearchQuote(searchQuery, page));
      });
    });

    // on<GetQuotes>((event, emit) async {
    //   final result = await _getQuotesUseCase.execute();
    //   result.fold((left) {}, (right) {
    //     emit(GotQuotes(right));
    //   });
    // });
    on<SearchQuote>((event, emit) async {
      await _searchQuote(event.page, event.query, emit);
    });
    on<OnSearchTextChanged>((event, emit) {
      searchQuery = event.query;
      page = event.page;

      // Cancel previous timer if still active
      if (_debounce?.isActive ?? false) {
        _debounce!.cancel();
      }

      // Start new timer
      _debounce = Timer(const Duration(milliseconds: 500), () async {
        add(SearchQuote(event.query, event.page));
      });
    });
  }

  Future<void> _searchQuote(
    int searchPage,
    String query,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchingQuotes());
    final result = await _getSearchUseCase.call();
    result.fold((left) {}, (right) {
      emit(SearchedQuotes(right));
    });
  }
}
