/// Bloc for managing preferences functionality.
///
/// This bloc handles all preferences-related operations including streak data
/// management, sharing functionality, and practice session generation. It coordinates
/// multiple use cases to provide a unified interface for preferences management.
///
/// Key responsibilities:
/// - Managing streak data retrieval and display
/// - Handling streak post sharing with image generation
/// - Coordinating practice session generation
/// - Managing favourites count display
/// - Providing haptic feedback for user interactions
/// - Maintaining state consistency across operations

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/common/domain/use_cases/convert_widget_to_png_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_last_seven_days_streak_data_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_total_streak_score_use_case.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/default/presentation/bloc/preferences_event.dart';
import 'package:sureline/features/preferenecs/default/presentation/bloc/preferences_state.dart';
import 'package:sureline/common/domain/use_cases/favourites/get_favourites_count_use_case.dart';
import 'package:sureline/common/domain/use_cases/recommendation_algorithm/get_quotes_from_recommendation_algorithm.dart';
import 'package:sureline/features/streak/presentation/share_streak_render_widget.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  /// Use case for converting widgets to PNG images.
  final ConvertWidgetToPngUseCase _convertWidgetToPngUseCase;

  /// Use case for retrieving last seven days streak data.
  final GetLastSevenDaysStreakDataUseCase _getLastSevenDaysStreakDataUseCase;

  /// Use case for getting total streak score.
  final GetTotalStreakScoreUseCase _getTotalStreakScoreUseCase;

  /// Use case for getting favourites count.
  final GetFavouritesCountUseCase _getFavouritesCountUseCase;

  /// Use case for getting random quotes from recommendation algorithm.
  final GetQuotesFromRecommendationAlgorithm _getQuotesFromRecommendationAlgorithm;

  /// Shared preferences instance for persistent storage.
  final SharedPreferences prefs;

  /// Creates a new PreferencesBloc instance.
  ///
  /// [getLastSevenDaysStreakDataUseCase] - Use case for getting streak data
  /// [getTotalStreakScoreUseCase] - Use case for getting total streak score
  /// [convertWidgetToPngUseCase] - Use case for converting widgets to PNG
  /// [getFavouritesCountUseCase] - Use case for getting favourites count
  /// [getQuotesFromRecommendationAlgorithm] - Use case for getting random quotes
  /// [prefs] - Shared preferences instance
  PreferencesBloc({
    required GetLastSevenDaysStreakDataUseCase getLastSevenDaysStreakDataUseCase,
    required GetTotalStreakScoreUseCase getTotalStreakScoreUseCase,
    required ConvertWidgetToPngUseCase convertWidgetToPngUseCase,
    required GetFavouritesCountUseCase getFavouritesCountUseCase,
    required GetQuotesFromRecommendationAlgorithm getQuotesFromRecommendationAlgorithm,
    required SharedPreferences prefs,
  }) : _getLastSevenDaysStreakDataUseCase = getLastSevenDaysStreakDataUseCase,
       _getTotalStreakScoreUseCase = getTotalStreakScoreUseCase,
       _convertWidgetToPngUseCase = convertWidgetToPngUseCase,
       _getFavouritesCountUseCase = getFavouritesCountUseCase,
       _getQuotesFromRecommendationAlgorithm = getQuotesFromRecommendationAlgorithm,
       this.prefs = prefs,
       super(Initial()) {
    on<GetLastSevenDaysStreakData>((event, emit) {
      final result = _getLastSevenDaysStreakDataUseCase.execute();
      result.fold((left) {}, (right) {
        emit(GotLastSevenDaysStreakData(right));
      });
    });

    on<GetStreakStatus>((event, emit) {
      final isEnabled = prefs.getBool(SP.streakEnable) ?? true;
      emit(GotStreakStatus(isEnabled: isEnabled));
    });

    on<OnShareStreakPressed>((event, emit) async {
      emit(const RenderingStreakPost());

      final scoreResult = _getTotalStreakScoreUseCase.execute();
      await scoreResult.fold((left) {}, (right) async {
        final result = await _convertWidgetToPngUseCase.execute(
          ShareStreakRenderWidget(
            streakScore: right.toString(),
            width: event.screenWidth,
            height: event.screenHeight,
          ),
          screenHeight: event.screenHeight,
          screenWidth: event.screenWidth,
          pixelRatio: 3,
        );
        HapticFeedback.lightImpact();
        await result.fold((left) {}, (right) async {
          await Share.shareXFiles([XFile(right)]);
        });
        emit(const RenderedStreakPost());
      });
    });

    on<GetRandomQuotes>((event, emit) async {
      final quotesLength = _getRandomQuotesLength(event.option);
      final perQuoteDuration = _getPerQuoteDuration(event.option);
      final isPremium = await Utils.checkPremiumStatus();
      final result = await _getQuotesFromRecommendationAlgorithm.call(
        limit: quotesLength,
        isPremium: isPremium,
      );
      result.fold((left) {}, (right) {
        emit(GotRandomQuotes(right, perQuoteDuration));
      });
    });

    on<GetFavouritesCount>((event, emit) async {
      final result = await _getFavouritesCountUseCase.call();
      result.fold((left) {}, (right) {
        emit(GotFavouritesCount(right));
      });
    });
  }

  /// Returns the number of quotes to fetch based on the selected option.
  ///
  /// Determines the number of quotes to generate for practice sessions
  /// based on the user's selected option. Different options provide
  /// varying session lengths and quote counts.
  ///
  /// [option]: The practice option (0=6quotes, 1=30quotes, 2=90quotes)
  /// Returns: The number of quotes to generate
  int _getRandomQuotesLength(int option) {
    switch (option) {
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

  /// Returns the duration per quote based on the selected option.
  ///
  /// Calculates the duration allocated per quote in practice sessions
  /// based on the user's selected option. This ensures proper timing
  /// for different session lengths.
  ///
  /// [option]: The practice option (0=1min, 1=5min, 2=15min)
  /// Returns: The duration per quote for the session
  Duration _getPerQuoteDuration(int option) {
    switch (option) {
      case 0:
        const minutes = 1;
        const quotes = 6;
        return Duration(seconds: (minutes * 60) ~/ quotes);
      case 1:
        const minutes = 5;
        const quotes = 30;
        return Duration(seconds: (minutes * 60) ~/ quotes);
      case 2:
        const minutes = 15;
        const quotes = 90;
        return Duration(seconds: (minutes * 60) ~/ quotes);
      default:
        const minutes = 1;
        const quotes = 6;
        return Duration(seconds: (minutes * 60) ~/ quotes);
    }
  }
}
