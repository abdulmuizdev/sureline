/// Abstract base class for all preferences events.
///
/// Provides a common interface for all preferences-related events.
/// This abstract class ensures type safety and consistent event handling
/// across the preferences bloc. Events handle various user interactions
/// and system triggers for preferences management.
abstract class PreferencesEvent {
  const PreferencesEvent();
}

/// Event to get the last seven days streak data.
///
/// Triggers the retrieval of streak data for the past seven days.
/// This event is typically dispatched when the preferences page loads
/// to display the user's recent streak activity in a visual format.
/// The data is used to populate the streak container widget.
class GetLastSevenDaysStreakData extends PreferencesEvent {
  const GetLastSevenDaysStreakData();
}

/// Event to share streak post with specified screen dimensions.
///
/// Triggers the creation and sharing of a streak post image.
/// This event handles the complete sharing workflow including:
/// - Converting the streak widget to a PNG image
/// - Applying proper screen dimensions and pixel ratio
/// - Providing haptic feedback
/// - Sharing the generated image via the system share sheet
///
/// [screenWidth]: The width of the screen for image generation
/// [screenHeight]: The height of the screen for image generation
class OnShareStreakPressed extends PreferencesEvent {
  final double screenWidth;
  final double screenHeight;

  const OnShareStreakPressed({required this.screenWidth, required this.screenHeight});
}

/// Event to get the current streak status.
///
/// Retrieves the current streak enable/disable status from shared preferences.
/// This event is used to determine whether streak features should be displayed
/// or hidden based on user preferences.
class GetStreakStatus extends PreferencesEvent {
  const GetStreakStatus();
}

/// Event to get the favourites count.
///
/// Retrieves the total number of favourite quotes stored by the user.
/// This event is used to display the favourites count in the preferences
/// interface, providing users with a quick overview of their saved content.
class GetFavouritesCount extends PreferencesEvent {
  const GetFavouritesCount();
}

/// Event to get random quotes based on the specified option.
///
/// Triggers the generation of random quotes for practice sessions.
/// The number of quotes and duration per quote are determined by the
/// selected option, providing different practice session lengths.
///
/// [option]: The practice option (0=1min/6quotes, 1=5min/30quotes, 2=15min/90quotes)
class GetRandomQuotes extends PreferencesEvent {
  final int option;

  const GetRandomQuotes(this.option);
}
