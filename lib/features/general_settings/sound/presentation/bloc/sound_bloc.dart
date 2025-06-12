import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/general_settings/sound/domain/use_cases/get_volume_use_case.dart';
import 'package:sureline/features/general_settings/sound/domain/use_cases/set_volume_use_case.dart';
import 'package:sureline/features/general_settings/sound/presentation/bloc/sound_event.dart';
import 'package:sureline/features/general_settings/sound/presentation/bloc/sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundState>{
  final GetVolumeUseCase _getVolumeUseCase;
  final SetVolumeUseCase _setVolumeUseCase;

  SoundBloc(this._setVolumeUseCase, this._getVolumeUseCase): super(Initial()){
    on<GetVolume>((event, emit) async{
      final result = await _getVolumeUseCase.execute();
      result.fold((left){}, (right){
        emit(GotVolume(right));
      });
    });

    on<SetVolume>((event, emit) async{
      final result = await _setVolumeUseCase.execute(event.volume);
      result.fold((left){}, (right){
        emit(SetVolumeCompleted());
      });
    });
  }
}