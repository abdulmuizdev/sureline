import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/entities/streak_entity.dart';
import 'package:sureline/common/domain/use_cases/streak/clear_streak_data_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_all_streak_data_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_last_check_in_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_last_seven_days_streak_data_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/is_streak_broken_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/log_streak_entry_use_case.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/favourites/domain/use_cases/add_favourite_use_case.dart';
import 'package:sureline/features/favourites/domain/use_cases/get_favourites_count_use_case.dart';
import 'package:sureline/features/favourites/domain/use_cases/remove_favourite_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/feed/is_feed_setup_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/like/guide/is_like_guide_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/share/is_share_guide_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/swipe/is_swipe_completed_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/feed/set_feed_setup_to_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/like/guide/set_like_guide_to_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/set_onboarding_to_completed_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/share/set_share_guide_to_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/swipe/set_swipe_to_completed_use_case.dart';
import 'package:sureline/features/home/presentation/bloc/home_event.dart';
import 'package:sureline/features/home/presentation/bloc/home_state.dart';
import 'package:sureline/common/domain/use_cases/streak/can_log_streak_entry_use_case.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/edit_notification_preset_use_case.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/get_notification_presets_use_case.dart';
import 'package:sureline/features/recommendation_algorithm/domain/use_cases/get_quotes_from_recommendation_algorithm.dart';
import 'package:sureline/features/recommendation_algorithm/domain/use_cases/mark_quote_as_shown_use_case.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetQuotesFromRecommendationAlgorithm
  _getQuotesFromRecommendationAlgorithm;
  final SetOnboardingToCompletedUseCase _setOnboardingToCompletedUseCase;

  final IsSwipeCompletedUseCase _isSwipeCompletedUseCase;
  final SetSwipeToCompletedUseCase _setSwipeToCompletedUseCase;

  final IsFeedSetupShownUseCase _isFeedSetupShownUseCase;
  final IsLikeGuideShownUseCase _isLikeGuideShownUseCase;
  final IsShareGuideShownUseCase _isShareGuideShownUseCase;

  final SetFeedSetupToShownUseCase _setFeedSetupToShownUseCase;
  final SetLikeGuideToShownUseCase _setLikeGuideToShownUseCase;
  final SetShareGuideToShownUseCase _setShareGuideToShownUseCase;

  final IsStreakBrokenUseCase _isStreakBrokenUseCase;
  final GetLastCheckInUseCase _getLastCheckInUseCase;
  final CanLogStreakEntryUseCase _canLogStreakEntryUseCase;
  final LogStreakEntryUseCase _logStreakEntryUseCase;
  final GetLastSevenDaysStreakDataUseCase _getLastSevenDaysStreakDataUseCase;
  final ClearStreakDataUseCase _clearStreakDataUseCase;
  final GetAllStreakDataUseCase _getAllStreakDataUseCase;

  final GetNotificationPresetsUseCase _getNotificationPresetsUseCase;
  final EditNotificationPresetUseCase _editNotificationPresetUseCase;

  // final SaveLikedQuoteUseCase _saveLikedQuoteUseCase;
  final AddFavouriteUseCase _addFavouriteUseCase;
  final GetFavouritesCountUseCase _getFavouritesCountUseCase;
  final RemoveFavouriteUseCase _removeFavouriteUseCase;
  final MarkQuoteAsShownUseCase _markQuoteAsShownUseCase;

  HomeBloc(
    this._getQuotesFromRecommendationAlgorithm,
    this._setOnboardingToCompletedUseCase,
    this._setSwipeToCompletedUseCase,
    this._isSwipeCompletedUseCase,
    this._isShareGuideShownUseCase,
    this._setShareGuideToShownUseCase,
    this._setLikeGuideToShownUseCase,
    this._setFeedSetupToShownUseCase,
    this._isLikeGuideShownUseCase,
    this._isFeedSetupShownUseCase,
    this._canLogStreakEntryUseCase,
    this._logStreakEntryUseCase,
    this._getLastCheckInUseCase,
    this._getLastSevenDaysStreakDataUseCase,
    this._isStreakBrokenUseCase,
    this._clearStreakDataUseCase,
    this._getAllStreakDataUseCase,
    this._getNotificationPresetsUseCase,
    this._editNotificationPresetUseCase,
    // this._saveLikedQuoteUseCase,
    this._addFavouriteUseCase,
    this._getFavouritesCountUseCase,
    this._removeFavouriteUseCase,
    this._markQuoteAsShownUseCase,
  ) : super(Initial()) {
    on<GetQuotes>((event, emit) async {
      final result = await _getQuotesFromRecommendationAlgorithm.call(
        event.page,
      );
      result.fold(
        (left) {
          emit(HomeError(left.message));
        },
        (right) {
          final temp = [...right];
          emit(GotQuotes(temp));
        },
      );
    });

    on<MarkQuoteAsShown>((event, emit) async {
      final result = await _markQuoteAsShownUseCase.call(event.id);
      result.fold((left) {}, (right) {
        emit(QuoteAsShown());
      });
    });

    on<OnboardingComplete>((event, emit) async {
      _setOnboardingToCompletedUseCase.execute();
    });
    on<OnSwipeComplete>((event, emit) async {
      _setSwipeToCompletedUseCase.execute();
      emit(GotSwipeCompleteState(true));
    });

    on<OnFeedSetupShown>((event, emit) {
      _setFeedSetupToShownUseCase.execute();
      emit(GotFeedSetupState(true));
    });
    on<OnLikeGuideShown>((event, emit) {
      _setLikeGuideToShownUseCase.execute();
      emit(GotLikeGuideState(true));
    });
    on<OnShareGuideShown>((event, emit) {
      _setShareGuideToShownUseCase.execute();
      emit(GotShareGuideState(true));
    });

    on<IsFeedSetupShown>((event, emit) async {
      final result = await _isFeedSetupShownUseCase.execute();
      result.fold((left) {}, (right) {
        emit(GotFeedSetupState(right));
      });
    });
    on<IsShareGuideShown>((event, emit) async {
      final result = await _isShareGuideShownUseCase.execute();
      result.fold((left) {}, (right) {
        emit(GotShareGuideState(right));
      });
    });
    on<IsLikeGuideShown>((event, emit) async {
      final result = await _isLikeGuideShownUseCase.execute();
      result.fold((left) {}, (right) {
        emit(GotLikeGuideState(right));
      });
    });

    on<IsSwipeComplete>((event, emit) async {
      final result = await _isSwipeCompletedUseCase.execute();
      result.fold((left) {}, (right) {
        emit(GotSwipeCompleteState(right));
      });
    });

    on<OnLikePressed>((event, emit) async {
      HapticFeedback.lightImpact();
      Either<Failure, int> result;
      if (event.isLiked) {
        await _addFavouriteUseCase.call(event.entity);
        result = await _getFavouritesCountUseCase.call();
      } else {
        // await _removeFavouriteUseCase.call(event.entity.id);
        result = await _getFavouritesCountUseCase.call();
      }
      result.fold((left) {}, (right) {
        emit(GotLikeCount(right));
      });
    });

    on<GetLikeCount>((event, emit) async {
      final result = await _getFavouritesCountUseCase.call();
      result.fold((left) {}, (right) {
        emit(GotLikeCount(right));
      });
    });

    on<UpdateStreak>((event, emit) async {
      final allStreakDataResult = _getAllStreakDataUseCase.execute();
      await allStreakDataResult.fold((left) {}, (right) async {
        await _checkForBrokenStreak(right, emit);
      });
    });

    on<GetLastSevenDaysStreakData>((event, emit) {
      final result = _getLastSevenDaysStreakDataUseCase.execute();
      result.fold(
        (left) {
          debugPrint(left.message);
        },
        (right) {
          emit(GotLastSevenDaysStreakData(right));
        },
      );
    });
  }

  Future<void> _checkForBrokenStreak(
    List<StreakEntity> entities,
    Emitter<HomeState> emit,
  ) async {
    final brokenCheckResult = _isStreakBrokenUseCase.execute(entities);
    await brokenCheckResult.fold((left) {}, (broken) async {
      if (broken) {
        await _handleBrokenStreak(emit);
      } else {
        await _handleOnGoingStreak(emit);
      }
    });
  }

  Future<void> _handleOnGoingStreak(Emitter<HomeState> emit) async {
    final result = _getLastCheckInUseCase.execute();

    await result.fold((left) {}, (right) async {
      bool canLog = _canLogStreakEntryUseCase.execute(
        lastCheckIn: right?.timeStamp,
      );
      if (canLog) {
        await _handleStreakLog(emit);
      }
    });
  }

  Future<void> _handleBrokenStreak(Emitter<HomeState> emit) async {
    emit(StreakIsBroken());
    await _clearStreakDataUseCase.execute();
    await _handleStreakLog(emit);
  }

  Future<void> _handleStreakLog(Emitter<HomeState> emit) async {
    final status = await _logStreakEntryUseCase.execute();
    await status.fold((failed) {}, (successful) async {
      final presets = await _getNotificationPresetsUseCase.execute();
      await presets.fold((left) {}, (right) async {
        final entity = right.singleWhere(
          (entity) => entity.isStreakReminder == true,
        );
        final now = DateTime.now();
        await _editNotificationPresetUseCase.execute(
          entity.copyWith(
            startTime: TimeOfDay(hour: now.hour, minute: now.minute),
            endTime: TimeOfDay(hour: now.hour, minute: now.minute),
          ),
        );
      });
      final lastSevenDaysData = _getLastSevenDaysStreakDataUseCase.execute();
      lastSevenDaysData.fold((left) {}, (right) {
        emit(ShowStreakBottomSheet(right));
      });
    });
  }
}
