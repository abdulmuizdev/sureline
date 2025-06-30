import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/general_settings/muted_content/domain/use_case/get_muted_content_use_case.dart';
import 'package:sureline/features/general_settings/muted_content/domain/use_case/update_muted_content_use_case.dart';
import 'package:sureline/features/general_settings/muted_content/presentation/bloc/muted_content_event.dart';
import 'package:sureline/features/general_settings/muted_content/presentation/bloc/muted_content_state.dart';

class MutedContentBloc extends Bloc<MutedContentEvent, MutedContentState> {
  final GetMutedContentUseCase _getMutedContentUseCase;
  final UpdateMutedContentUseCase _updateMutedContentUseCase;

  MutedContentBloc(
    this._getMutedContentUseCase,
    this._updateMutedContentUseCase,
  ) : super(Initial()) {
    on<GetMutedContentOptions>((event, emit) {
      emit(GettingMutedContentOptions());
      final result = _getMutedContentUseCase.execute();
      result.fold((left) {}, (right) {
        emit(GotMutedContentOptions(right));
      });
    });

    on<OnMutedContentPressed>((event, emit) async {
      final result = await _updateMutedContentUseCase.execute(
        event.mutedContent,
      );
      result.fold((left) {}, (right) {
        final mutedContentResult = _getMutedContentUseCase.execute();
        mutedContentResult.fold((left) {}, (right) {
          emit(GotMutedContentOptions(right));
        });
      });
    });
  }
}
