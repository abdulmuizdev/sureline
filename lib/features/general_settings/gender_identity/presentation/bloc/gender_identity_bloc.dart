import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/constants/sureline_gender_identities.dart';
import 'package:sureline/features/general_settings/gender_identity/domain/domain/gender_identity_entity.dart';
import 'package:sureline/features/general_settings/gender_identity/domain/use_case/get_gender_identities_use_case.dart';
import 'package:sureline/features/general_settings/gender_identity/domain/use_case/update_gender_identities_use_case.dart';
import 'package:sureline/features/general_settings/gender_identity/presentation/bloc/gender_identity_event.dart';
import 'package:sureline/features/general_settings/gender_identity/presentation/bloc/gender_identity_state.dart';

class GenderIdentityBloc
    extends Bloc<GenderIdentityEvent, GenderIdentityState> {
  final GetGenderIdentitiesUseCase _getGenderIdentitiesUseCase;
  final UpdateGenderIdentitiesUseCase _updateGenderIdentitiesUseCase;

  GenderIdentityBloc(
    this._getGenderIdentitiesUseCase,
    this._updateGenderIdentitiesUseCase,
  ) : super(Initial()) {
    on<GetGenderIdentities>((event, emit) {
      emit(GettingGenderIdentities());
      final result = _getGenderIdentitiesUseCase.execute();
      result.fold((left) {}, (right) {
        emit(GotGenderIdentities(right));
      });
    });

    on<OnGenderIdentityPressed>((event, emit) async {
      final result = await _updateGenderIdentitiesUseCase.execute(event.genderIdentities);
      result.fold((left){}, (right){
        final contentPrefResult = _getGenderIdentitiesUseCase.execute();
        contentPrefResult.fold((left){}, (right){
          emit(GotGenderIdentities(right));
        });
      });
    });
  }
}
