import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/use_cases/own_quotes/get_own_quotes_use_case.dart';
import 'package:sureline/common/domain/use_cases/own_quotes/record/remove_own_quote_use_case.dart';
import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_event.dart';
import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_state.dart';

class OwnQuotesBloc extends Bloc<OwnQuotesEvent, OwnQuotesState> {
  final GetOwnQuotesUseCase _getOwnQuotesUseCase;
  final RemoveOwnQuoteUseCase _removeOwnQuoteUseCase;

  OwnQuotesBloc(this._getOwnQuotesUseCase, this._removeOwnQuoteUseCase)
    : super(Initial()) {
    on<GetOwnQuotes>((event, emit) {
      _getOwnQuotes(emit);
    });

    on<OnDeletePressed>((event, emit) async {
      final result = await _removeOwnQuoteUseCase.execute(event.entity);
      result.fold((left) {}, (right) {
        _getOwnQuotes(emit);
      });
    });
  }
  void _getOwnQuotes(Emitter<OwnQuotesState> emit) async {
    final result = _getOwnQuotesUseCase.execute();
    result.fold((left) {}, (right) {
      emit(GotOwnQuotes(right));
    });
  }
}
