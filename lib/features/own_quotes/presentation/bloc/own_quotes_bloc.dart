import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/own_quotes/domain/use_cases/add_own_quote_use_case.dart';
import 'package:sureline/features/own_quotes/domain/use_cases/get_all_own_quotes_use_case.dart';
import 'package:sureline/features/own_quotes/domain/use_cases/remove_own_quote_use_case.dart';
import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_event.dart';
import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_state.dart';

class OwnQuotesBloc extends Bloc<OwnQuotesEvent, OwnQuotesState> {
  final GetAllOwnQuotesUseCase _getAllOwnQuotesUseCase;
  final AddOwnQuoteUseCase _addOwnQuoteUseCase;
  final RemoveOwnQuoteUseCase _removeOwnQuoteUseCase;

  OwnQuotesBloc(
    this._getAllOwnQuotesUseCase,
    this._addOwnQuoteUseCase,
    this._removeOwnQuoteUseCase,
  ) : super(Initial()) {
    on<GetOwnQuotes>((event, emit) async {
      await _getOwnQuotes(emit);
    });

    on<OnDeletePressed>((event, emit) async {
      final result = await _removeOwnQuoteUseCase.call(event.entity.id);
      await result.fold((left) {}, (right) async {
        await _getOwnQuotes(emit);
      });
    });

    on<SaveOwnQuote>((event, emit) async {
      final result = await _addOwnQuoteUseCase.call(event.entity);
      await result.fold((_) {}, (_) async {
        final updatedQuotesResult = await _getAllOwnQuotesUseCase.call();
        updatedQuotesResult.fold((left) {}, (right) {
          emit(SavedOwnQuote(right));
        });
      });
    });
  }
  Future<void> _getOwnQuotes(Emitter<OwnQuotesState> emit) async {
    final result = await _getAllOwnQuotesUseCase.call();
    result.fold((left) {}, (right) {
      emit(GotOwnQuotes(right));
    });
  }
}
