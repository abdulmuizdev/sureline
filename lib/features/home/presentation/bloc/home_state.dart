import 'package:sureline/common/domain/entities/streak_display_entity.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';

abstract class HomeState {
  const HomeState();
}

class Initial extends HomeState {
  const Initial();
}

class GettingQuotes extends HomeState {
  const GettingQuotes();
}

class GotQuotes extends HomeState {
  final List<QuoteEntity> result;
  const GotQuotes(this.result);
}

class GotSwipeCompleteState extends HomeState {
  final bool isCompleted;
  GotSwipeCompleteState(this.isCompleted);
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}

class GotLikeCount extends HomeState {
  final int likeCount;
  GotLikeCount(this.likeCount);
}

class GotFeedSetupState extends HomeState {
  final bool isShown;
  GotFeedSetupState(this.isShown);
}

class GotLikeGuideState extends HomeState {
  final bool isShown;
  GotLikeGuideState(this.isShown);
}

class GotShareGuideState extends HomeState {
  final bool isShown;
  GotShareGuideState(this.isShown);
}

class ShowStreakBottomSheet extends HomeState {
  final List<StreakDisplayEntity> streakData;
  ShowStreakBottomSheet(this.streakData);
}

class GotLastSevenDaysStreakData extends HomeState {
  final List<StreakDisplayEntity> streakData;
  GotLastSevenDaysStreakData(this.streakData);
}

class StreakIsBroken extends HomeState {
  const StreakIsBroken();
}

class QuoteAsShown extends HomeState {
  QuoteAsShown();
}
