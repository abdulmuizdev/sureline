/// Events for home screen state management.
///
/// Handles quote loading, user interactions, and guide states.

import 'package:sureline/common/domain/entities/recommendation_algorithm/quote_entity.dart';

/// Base class for home screen events.
abstract class HomeEvent {
  const HomeEvent();
}

/// Event to fetch quotes for a specific page.
class GetQuotes extends HomeEvent {
  final int page;
  final bool isPremium;
  const GetQuotes(this.page, this.isPremium);
}

/// Event to mark onboarding as completed.
class OnboardingComplete extends HomeEvent {
  const OnboardingComplete();
}

/// Event to mark swipe tutorial as completed.
class OnSwipeComplete extends HomeEvent {
  const OnSwipeComplete();
}

/// Event to check if swipe tutorial is completed.
class IsSwipeComplete extends HomeEvent {
  const IsSwipeComplete();
}

/// Event when like button is pressed.
class OnLikePressed extends HomeEvent {
  final QuoteEntity entity;
  final bool isLiked;
  const OnLikePressed(this.isLiked, this.entity);
}

/// Event to get current like count.
class GetLikeCount extends HomeEvent {
  const GetLikeCount();
}

/// Event to mark like guide as shown.
class OnLikeGuideShown extends HomeEvent {
  const OnLikeGuideShown();
}

/// Event to mark share guide as shown.
class OnShareGuideShown extends HomeEvent {
  const OnShareGuideShown();
}

/// Event to mark feed setup as shown.
class OnFeedSetupShown extends HomeEvent {
  const OnFeedSetupShown();
}

/// Event to check if like guide is shown.
class IsLikeGuideShown extends HomeEvent {
  const IsLikeGuideShown();
}

/// Event to check if share guide is shown.
class IsShareGuideShown extends HomeEvent {
  const IsShareGuideShown();
}

/// Event to check if feed setup is shown.
class IsFeedSetupShown extends HomeEvent {
  const IsFeedSetupShown();
}

/// Event to update user streak.
class UpdateStreak extends HomeEvent {
  const UpdateStreak();
}

/// Event to get last seven days streak data.
class GetLastSevenDaysStreakData extends HomeEvent {
  const GetLastSevenDaysStreakData();
}

/// Event to mark a quote as shown.
class MarkQuoteAsShown extends HomeEvent {
  final int id;
  const MarkQuoteAsShown(this.id);
}
