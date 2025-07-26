import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/use_case/get_gender_identities_use_case.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/use_case/update_gender_identities_use_case.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/presentation/bloc/gender_identity_event.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/presentation/bloc/gender_identity_state.dart';

/// Bloc for managing gender identity-related state and operations.
class GenderIdentityBloc extends Bloc<GenderIdentityEvent, GenderIdentityState> {
  final GetGenderIdentitiesUseCase _getGenderIdentitiesUseCase;
  final UpdateGenderIdentitiesUseCase _updateGenderIdentitiesUseCase;

  /// Creates a new GenderIdentityBloc instance.
  GenderIdentityBloc({
    required GetGenderIdentitiesUseCase getGenderIdentitiesUseCase,
    required UpdateGenderIdentitiesUseCase updateGenderIdentitiesUseCase,
  }) : _getGenderIdentitiesUseCase = getGenderIdentitiesUseCase,
       _updateGenderIdentitiesUseCase = updateGenderIdentitiesUseCase,
       super(const Initial()) {
    on<GetGenderIdentities>((event, emit) {
      emit(const GettingGenderIdentities());
      final result = _getGenderIdentitiesUseCase.execute();
      result.fold((left) {}, (right) {
        emit(GotGenderIdentities(right));
      });
    });

    on<OnGenderIdentityPressed>((event, emit) async {
      final result = await _updateGenderIdentitiesUseCase.execute(event.genderIdentities);
      result.fold((left) {}, (right) {
        final contentPrefResult = _getGenderIdentitiesUseCase.execute();
        contentPrefResult.fold((left) {}, (right) {
          emit(GotGenderIdentities(right));
        });
      });
    });
  }
}
