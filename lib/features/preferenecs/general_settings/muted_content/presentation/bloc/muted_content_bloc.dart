import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/muted_content/domain/entity/muted_content_entity.dart';
import 'package:sureline/features/preferenecs/general_settings/muted_content/presentation/bloc/muted_content_event.dart';
import 'package:sureline/features/preferenecs/general_settings/muted_content/presentation/bloc/muted_content_state.dart';
import 'package:sureline/features/recommendation_algorithm/domain/use_cases/update_muted_content_use_case.dart';
import 'package:sureline/features/recommendation_algorithm/domain/use_cases/get_muted_content_use_case.dart';

class MutedContentBloc extends Bloc<MutedContentEvent, MutedContentState> {
  final GetMutedContentUseCase _getMutedContentOptionsUseCase;
  final UpdateMutedContentUseCase _updateMutedContentUseCase;

  MutedContentBloc(
    this._getMutedContentOptionsUseCase,
    this._updateMutedContentUseCase,
  ) : super(Initial()) {
    on<GetMutedContentOptions>((event, emit) async {
      emit(GettingMutedContentOptions());
      final result = await _getMutedContentOptionsUseCase.call();
      result.fold((left) {}, (right) {
        if (right.isNotEmpty) {
          emit(GotMutedContentOptions(right.first));
        } else {
          emit(
            GotMutedContentOptions(
              MutedContentEntity(
                isWithAuthorMuted: false,
                isWithoutAuthorMuted: false,
              ),
            ),
          );
        }
      });
    });

    on<OnMutedContentPressed>((event, emit) async {
      final result = await _updateMutedContentUseCase.call(
        withoutAuthor: event.mutedContent.first.isWithoutAuthorMuted,
        withAuthor: event.mutedContent.first.isWithAuthorMuted,
      );
      await result.fold((left) {}, (right) async {
        final mutedContentResult = await _getMutedContentOptionsUseCase.call();
        mutedContentResult.fold((left) {}, (right) {
          if (right.isNotEmpty) {
            emit(GotMutedContentOptions(right.first));
          } else {
            emit(
              GotMutedContentOptions(
                MutedContentEntity(
                  isWithAuthorMuted: false,
                  isWithoutAuthorMuted: false,
                ),
              ),
            );
          }
        });
      });
    });
  }
}
