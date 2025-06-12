import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/use_cases/quote/get_quotes_search_results_use_case.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/use_cases/like/decrement_like_count_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/like/increment_like_count_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/like/record/remove_liked_quote_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/like/record/save_liked_quote_use_case.dart';
import 'package:sureline/features/search/presentation/bloc/search_event.dart';
import 'package:sureline/features/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetQuotesSearchResultsUseCase _getQuotesSearchResultsUseCase;

  // final GetQuotesUseCase _getQuotesUseCase;

  final SaveLikedQuoteUseCase _saveLikedQuoteUseCase;
  final IncrementLikeCountUseCase _incrementLikeCountUseCase;
  final DecrementLikeCountUseCase _decrementLikeCountUseCase;
  final RemoveLikedQuoteUseCase _removeLikedQuoteUseCase;

  String searchQuery = '';
  int page = 1;
  Timer? _debounce;

  SearchBloc(
    this._getQuotesSearchResultsUseCase,
    // this._getQuotesUseCase,
    this._decrementLikeCountUseCase,
    this._removeLikedQuoteUseCase,
    this._incrementLikeCountUseCase,
    this._saveLikedQuoteUseCase,
  ) : super(Initial()) {
    on<OnLikePressed>((event, emit) async {
      HapticFeedback.lightImpact();
      Either<Failure, int> result;
      if (event.isLiked) {
        await _saveLikedQuoteUseCase.execute(event.entity);
        result = await _incrementLikeCountUseCase.execute();
      } else {
        await _removeLikedQuoteUseCase.execute(event.entity);
        result = await _decrementLikeCountUseCase.execute();
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
    final result = await _getQuotesSearchResultsUseCase.execute(
      query,
      searchPage,
    );
    result.fold((left) {}, (right) {
      emit(SearchedQuotes(right));
    });
  }
}
