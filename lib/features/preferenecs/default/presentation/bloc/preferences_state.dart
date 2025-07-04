import 'package:sureline/common/domain/entities/streak_display_entity.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';

abstract class PreferencesState {
  const PreferencesState();
}

class Initial extends PreferencesState {}

class GotLastSevenDaysStreakData extends PreferencesState {
  final List<StreakDisplayEntity> result;

  GotLastSevenDaysStreakData(this.result);
}

class RenderingStreakPost extends PreferencesState {
  const RenderingStreakPost();
}

class RenderedStreakPost extends PreferencesState {
  const RenderedStreakPost();
}

class GotStreakStatus extends PreferencesState {
  final bool isEnabled;

  const GotStreakStatus(this.isEnabled);
}

class GotFavouritesCount extends PreferencesState {
  final int count;

  GotFavouritesCount(this.count);
}

class GotRandomQuotes extends PreferencesState {
  final List<QuoteEntity> result;
  final Duration perQuoteDuration;
  GotRandomQuotes(this.result, this.perQuoteDuration);
}
