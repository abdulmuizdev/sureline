import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/common/domain/use_cases/convert_widget_to_png_use_case.dart';
import 'package:sureline/common/domain/use_cases/quote/get_liked_quotes_count_use_case.dart';
import 'package:sureline/common/domain/use_cases/quote/get_random_quotes_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_last_seven_days_streak_data_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_total_streak_score_use_case.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/features/preferenecs/presentation/bloc/preferences_event.dart';
import 'package:sureline/features/preferenecs/presentation/bloc/preferences_state.dart';
import 'package:sureline/features/streak/presentation/share_streak_render_widget.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final ConvertWidgetToPngUseCase _convertWidgetToPngUseCase;
  final GetLastSevenDaysStreakDataUseCase _getLastSevenDaysStreakDataUseCase;
  final GetTotalStreakScoreUseCase _getTotalStreakScoreUseCase;
  final GetLikedQuotesCountUseCase _getLikedQuotesCountUseCase;
  final GetRandomQuotesUseCase _getRandomQuotesUseCase;
  final SharedPreferences prefs;

  PreferencesBloc(
    this._getLastSevenDaysStreakDataUseCase,
    this._getTotalStreakScoreUseCase,
    this._convertWidgetToPngUseCase,
    this._getLikedQuotesCountUseCase,
    this._getRandomQuotesUseCase,
    this.prefs,
  ) : super(Initial()) {
    on<GetLastSevenDaysStreakData>((event, emit) {
      final result = _getLastSevenDaysStreakDataUseCase.execute();
      result.fold((left) {}, (right) {
        emit(GotLastSevenDaysStreakData(right));
      });
    });

    on<GetStreakStatus>((event, emit) {
      final isEnabled = prefs.getBool(SP.streakEnable) ?? true;
      emit(GotStreakStatus(isEnabled));
    });

    on<OnShareStreakPressed>((event, emit) async {
      emit(RenderingStreakPost());

      final scoreResult = _getTotalStreakScoreUseCase.execute();
      await scoreResult.fold((left) {}, (right) async {
        final result = await _convertWidgetToPngUseCase.execute(
          ShareStreakRenderWidget(streakScore: right.toString()),
          screenHeight: event.screenHeight,
          screenWidth: event.screenWidth,
          pixelRatio: 3,
        );
        HapticFeedback.lightImpact();
        await result.fold((left) {}, (right) async {
          final shareResult = await Share.shareXFiles([XFile(right)]);
        });
        emit(RenderedStreakPost());
      });
    });

    on<GetRandomQuotes>((event, emit) async {
      final quotesLength = _getRandomQuotesLength(event.option);
      final perQuoteDuration = _getPerQuoteDuration(event.option);
      final result = await _getRandomQuotesUseCase.execute(quotesLength);
      result.fold((left){}, (right){
        emit(GotRandomQuotes(right, perQuoteDuration));
      });
    });

    on<GetFavouritesCount>((event, emit){
      final result = _getLikedQuotesCountUseCase.execute();
      result.fold((left){}, (right){
        emit(GotFavouritesCount(right));
      });
    });
  }
  int _getRandomQuotesLength(int option){
    switch (option){
      case 0:
        return 6;
      case 1:
        return 30;
      case 2:
        return 90;
      default:
        return 6;
    }
  }

  Duration _getPerQuoteDuration(int option){
    switch (option){
      case 0:
        int minutes = 1;
        int quotes = 6;
        return Duration(seconds: (minutes * 60) ~/ quotes);
      case 1:
        int minutes = 5;
        int quotes = 30;
        return Duration(seconds: (minutes * 60) ~/ quotes);
      case 2:
        int minutes = 15;
        int quotes = 90;
        return Duration(seconds: (minutes * 60) ~/ quotes);
      default:
        int minutes = 1;
        int quotes = 6;
        return Duration(seconds: (minutes * 60) ~/ quotes);
    }
  }
}
