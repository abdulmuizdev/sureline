import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/data/model/voice_model.dart';

abstract class VoiceDataSource {
  Future<Either<Failure, List<VoiceModel>>> getVoices();

  Future<Either<Failure, VoiceModel?>> getVoice();

  Future<Either<Failure, void>> changeVoice(VoiceModel model);
}

class VoiceDataSourceImpl extends VoiceDataSource {
  @override
  Future<Either<Failure, List<VoiceModel>>> getVoices() async {
    try {
      FlutterTts tts = FlutterTts();
      final voices = await tts.getVoices;
      List<VoiceModel> models =
          (voices as List<dynamic>).map((raw) {
            return VoiceModel.fromJson(raw);
          }).toList();
      return Right(
        models.where((model) {
            if (model.locale.substring(0, 2) == 'en') {
              return true;
            }
            return false;
          }).toList()
          ..sort((a, b) => a.locale.compareTo(b.locale)),
      );
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, VoiceModel?>> getVoice() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(SP.voice);
      if (raw != null) {
        VoiceModel model = VoiceModel.fromJson(
          Map<Object?, Object?>.from(json.decode(raw)),
        );
        App.voice = model.toJson();
        return Right(model);
      }
      return Right(null);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> changeVoice(VoiceModel model) async {
    final tts = FlutterTts();
    await tts.stop();
    await tts.setVolume(App.volume);
    final rawVoice = model.toJson();
    await tts.setVoice(rawVoice);
    tts.speak('Hi, My name is ${model.name}');

    final prefs = await SharedPreferences.getInstance();
    final isSuccessful = await prefs.setString(SP.voice, jsonEncode(rawVoice));
    if (isSuccessful) {
      App.voice = rawVoice;
      return Right(unit);
    } else {
      return Left(UnknownFailure());
    }
  }
}
