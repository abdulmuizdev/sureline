import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class GetQuotes extends HomeEvent {
  final int page;
  const GetQuotes(this.page);
}

class OnboardingComplete extends HomeEvent {
  const OnboardingComplete();
}

class OnSwipeComplete extends HomeEvent {
  const OnSwipeComplete();
}

class IsSwipeComplete extends HomeEvent {
  const IsSwipeComplete();
}

class OnLikePressed extends HomeEvent {
  final QuoteEntity entity;
  final bool isLiked;
  const OnLikePressed(this.isLiked, this.entity);
}

class GetLikeCount extends HomeEvent {
  const GetLikeCount();
}

class OnLikeGuideShown extends HomeEvent {
  const OnLikeGuideShown();
}

class OnShareGuideShown extends HomeEvent {
  const OnShareGuideShown();
}

class OnFeedSetupShown extends HomeEvent {
  const OnFeedSetupShown();
}

class IsLikeGuideShown extends HomeEvent {
  const IsLikeGuideShown();
}

class IsShareGuideShown extends HomeEvent {
  const IsShareGuideShown();
}

class IsFeedSetupShown extends HomeEvent {
  const IsFeedSetupShown();
}

class UpdateStreak extends HomeEvent {
  const UpdateStreak();
}

class GetLastSevenDaysStreakData extends HomeEvent {
  const GetLastSevenDaysStreakData();
}

class MarkQuoteAsShown extends HomeEvent {
  final int id;
  const MarkQuoteAsShown(this.id);
}
