/// States for home screen state management.
///
/// Represents different UI states and data loading states.

import 'package:sureline/common/domain/entities/streak_display_entity.dart';
import 'package:sureline/common/domain/entities/recommendation_algorithm/quote_entity.dart';

/// Base class for home screen states.
abstract class HomeState {
  const HomeState();
}

/// Initial state when screen loads.
class Initial extends HomeState {
  const Initial();
}

/// State when quotes are being fetched.
class GettingQuotes extends HomeState {
  const GettingQuotes();
}

/// State when quotes have been successfully loaded.
class GotQuotes extends HomeState {
  final List<QuoteEntity> result;
  const GotQuotes(this.result);
}

/// State indicating swipe tutorial completion status.
class GotSwipeCompleteState extends HomeState {
  final bool isCompleted;
  GotSwipeCompleteState(this.isCompleted);
}

/// State when an error occurs.
class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}

/// State with current like count.
class GotLikeCount extends HomeState {
  final int likeCount;
  GotLikeCount(this.likeCount);
}

/// State indicating feed setup guide shown status.
class GotFeedSetupState extends HomeState {
  final bool isShown;
  GotFeedSetupState(this.isShown);
}

/// State indicating like guide shown status.
class GotLikeGuideState extends HomeState {
  final bool isShown;
  GotLikeGuideState(this.isShown);
}

/// State indicating share guide shown status.
class GotShareGuideState extends HomeState {
  final bool isShown;
  GotShareGuideState(this.isShown);
}

/// State to show streak bottom sheet.
class ShowStreakBottomSheet extends HomeState {
  final List<StreakDisplayEntity> streakData;
  ShowStreakBottomSheet(this.streakData);
}

/// State with last seven days streak data.
class GotLastSevenDaysStreakData extends HomeState {
  final List<StreakDisplayEntity> streakData;
  GotLastSevenDaysStreakData(this.streakData);
}

/// State when user streak is broken.
class StreakIsBroken extends HomeState {
  const StreakIsBroken();
}

/// State when a quote is marked as shown.
class QuoteAsShown extends HomeState {
  QuoteAsShown();
}
