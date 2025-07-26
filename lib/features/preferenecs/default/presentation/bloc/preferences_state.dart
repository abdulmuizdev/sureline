/// States for preferences management.
///
/// Represents different states of preferences operations and data.
/// These states represent the various UI states and data conditions
/// that can occur during preferences management, including loading,
/// success, and error states for different operations.

import 'package:sureline/common/domain/entities/streak_display_entity.dart';
import 'package:sureline/common/domain/entities/recommendation_algorithm/quote_entity.dart';

/// Abstract base class for all preferences states.
///
/// Provides a common interface for all preferences-related states.
/// This abstract class ensures type safety and consistent state handling
/// across the preferences bloc.
abstract class PreferencesState {
  const PreferencesState();
}

/// Initial state when no data has been loaded yet.
///
/// Represents the default state before any preferences operations.
/// This state is typically shown when the preferences feature is first loaded
/// or when the bloc is reset.
class Initial extends PreferencesState {
  const Initial();
}

/// State when streak data for the last seven days has been loaded.
///
/// Represents the state when streak data for the past seven days
/// has been successfully retrieved. This state contains the complete
/// list of streak display entities used to populate the streak container.
///
/// [result]: The list of streak display entities for the last seven days
class GotLastSevenDaysStreakData extends PreferencesState {
  final List<StreakDisplayEntity> result;

  const GotLastSevenDaysStreakData(this.result);
}

/// State when rendering a streak post.
///
/// Represents the state when a streak post image is being generated.
/// This state is used to show loading indicators and disable share
/// functionality during the rendering process.
class RenderingStreakPost extends PreferencesState {
  const RenderingStreakPost();
}

/// State when streak post rendering is complete.
///
/// Represents the state when a streak post image has been successfully
/// generated and is ready for sharing. This state re-enables share
/// functionality and indicates completion of the rendering process.
class RenderedStreakPost extends PreferencesState {
  const RenderedStreakPost();
}

/// State when streak status has been retrieved.
///
/// Represents the state when the streak enable/disable status has been
/// successfully retrieved from shared preferences. This state determines
/// whether streak features should be displayed in the UI.
///
/// [isEnabled]: Whether streak features are currently enabled
class GotStreakStatus extends PreferencesState {
  final bool isEnabled;

  const GotStreakStatus({required this.isEnabled});
}

/// State when favourites count has been retrieved.
///
/// Represents the state when the total number of favourite quotes has been
/// successfully retrieved. This state provides users with a quick overview
/// of their saved content count.
///
/// [count]: The total number of favourite quotes
class GotFavouritesCount extends PreferencesState {
  final int count;

  const GotFavouritesCount(this.count);
}

/// State when random quotes have been retrieved.
///
/// Represents the state when random quotes for practice sessions have been
/// successfully generated. This state contains both the quotes and the
/// calculated duration per quote for the practice session.
///
/// [result]: The list of random quotes for practice
/// [perQuoteDuration]: The duration allocated per quote in the session
class GotRandomQuotes extends PreferencesState {
  final List<QuoteEntity> result;
  final Duration perQuoteDuration;

  const GotRandomQuotes(this.result, this.perQuoteDuration);
}
