import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/data/model/voice_model.dart';

/// Abstract class defining the contract for voice data operations.
///
/// This interface defines the contract for all voice-related data operations,
/// including retrieving voices from the TTS engine, managing voice preferences,
/// and updating TTS engine configuration. It serves as the boundary between
/// the repository layer and the actual data sources (TTS engine, storage).
abstract class VoiceDataSource {
  /// Retrieves all available voices from the TTS engine.
  ///
  /// This method fetches all available text-to-speech voices from
  /// the device's TTS engine, filters them to show only English voices,
  /// and sorts them by locale for better user experience.
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (TTS engine error, etc.)
  /// - Right<List<VoiceModel>> - If the operation succeeds with the voices list
  Future<Either<Failure, List<VoiceModel>>> getVoices();

  /// Retrieves the currently selected voice from preferences.
  ///
  /// This method loads the user's saved voice preference from
  /// SharedPreferences and returns the corresponding VoiceModel.
  /// If no voice has been selected, it returns null.
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (storage error, etc.)
  /// - Right<VoiceModel?> - If the operation succeeds with the current voice (or null)
  Future<Either<Failure, VoiceModel?>> getVoice();

  /// Changes the current voice to the specified model.
  ///
  /// This method updates the TTS engine configuration with the new
  /// voice, provides a voice preview, and persists the selection
  /// to SharedPreferences for future use.
  ///
  /// [model] - The voice model to be set as the current voice
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (TTS engine error, storage error, etc.)
  /// - Right<void> - If the voice is successfully changed
  Future<Either<Failure, void>> changeVoice(VoiceModel model);
}

/// Implementation of VoiceDataSource that handles voice operations.
///
/// This class provides concrete implementations for all voice-related
/// data operations, including direct interactions with the FlutterTts
/// engine and SharedPreferences for persistence.
class VoiceDataSourceImpl implements VoiceDataSource {
  @override
  Future<Either<Failure, List<VoiceModel>>> getVoices() async {
    try {
      final FlutterTts tts = FlutterTts();
      final voices = await tts.getVoices;
      final List<VoiceModel> models =
          (voices as List<dynamic>)
              .map((raw) => VoiceModel.fromJson(Map<String, dynamic>.from(raw as Map)))
              .toList();
      return Right(
        models.where((model) => model.locale.substring(0, 2) == 'en').toList()
          ..sort((a, b) => a.locale.compareTo(b.locale)),
      );
    } catch (e) {
      debugPrint('$e');
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, VoiceModel?>> getVoice() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(SP.voice);
      if (raw != null) {
        final VoiceModel model = VoiceModel.fromJson(
          Map<String, dynamic>.from(json.decode(raw) as Map),
        );
        App.voice = model.toJson();
        return Right(model);
      }
      return Right(null);
    } catch (e) {
      debugPrint('$e');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> changeVoice(VoiceModel model) async {
    try {
      final tts = FlutterTts();
      await tts.stop();
      await tts.setVolume(App.volume);
      final rawVoice = model.toJson();
      await tts.setVoice(rawVoice);
      await tts.speak('Hi, My name is ${model.name}');

      final prefs = await SharedPreferences.getInstance();
      final isSuccessful = await prefs.setString(SP.voice, jsonEncode(rawVoice));
      if (isSuccessful) {
        App.voice = rawVoice;
        return const Right(null);
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('$e');
      return Left(UnknownFailure());
    }
  }
}
