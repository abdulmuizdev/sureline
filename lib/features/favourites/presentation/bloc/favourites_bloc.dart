import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/use_cases/quote/get_liked_quotes_use_case.dart';
import 'package:sureline/features/favourites/presentation/bloc/favourites_event.dart';
import 'package:sureline/features/favourites/presentation/bloc/favourites_state.dart';
import 'package:sureline/features/home/domain/use_cases/like/record/remove_liked_quote_use_case.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final GetLikedQuotesUseCase _getLikedQuotesUseCase;
  final RemoveLikedQuoteUseCase _removeLikedQuoteUseCase;

  FavouritesBloc(this._getLikedQuotesUseCase, this._removeLikedQuoteUseCase)
    : super(Initial()) {
    on<GetFavouriteQuotes>((event, emit) {
      _getFavouriteQuotes(emit);
    });

    on<OnDeletePressed>((event, emit) async {
      final result = await _removeLikedQuoteUseCase.execute(event.entity);
      result.fold((left){}, (right){
        _getFavouriteQuotes(emit);
      });
    });

  }
  void _getFavouriteQuotes(Emitter<FavouritesState> emit)async {
    final result = _getLikedQuotesUseCase.execute();
    result.fold((left) {}, (right) {
      emit(GotFavouriteQuotes(right));
    });
  }

}
