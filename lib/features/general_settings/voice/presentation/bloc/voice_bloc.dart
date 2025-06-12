import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/features/general_settings/voice/data/model/voice_model.dart';
import 'package:sureline/features/general_settings/voice/domain/use_cases/change_voice_use_case.dart';
import 'package:sureline/common/domain/use_cases/get_voice_use_case.dart';
import 'package:sureline/features/general_settings/voice/domain/use_cases/get_voices_use_case.dart';
import 'package:sureline/features/general_settings/voice/presentation/bloc/voice_event.dart';
import 'package:sureline/features/general_settings/voice/presentation/bloc/voice_state.dart';

class VoiceBloc extends Bloc<VoiceEvent, VoiceState> {
  final GetVoicesUseCase _getVoicesUseCase;
  final GetVoiceUseCase _getVoiceUseCase;
  final ChangeVoiceUseCase _changeVoiceUseCase;

  VoiceBloc(
    this._getVoicesUseCase,
    this._getVoiceUseCase,
    this._changeVoiceUseCase,
  ) : super(Initial()) {
    on<GetVoices>((event, emit) async {
      emit(GettingVoices());
      final result = await _getVoicesUseCase.execute();
      result.fold(
        (left) {
          emit(VoiceError(left.message));
        },
        (right) {
          int selectedIndex = 0;
          for (int i = 0; i < right.length; i++) {
            debugPrint(
              'checking ${VoiceModel.fromEntity(right[i]).toJson()} with ${App.voice}',
            );
            debugPrint('');
            if (VoiceModel.fromEntity(right[i]).toJson().toString() ==
                App.voice.toString()) {
              debugPrint('found it');
              selectedIndex = i;
            }
          }
          emit(GotVoices(right, selectedIndex));
        },
      );
    });

    on<OnVoiceItemPressed>((event, amit) async {
      await _changeVoiceUseCase.execute(event.entity);
    });
  }
}
