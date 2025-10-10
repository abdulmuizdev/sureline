/// Shared Preferences (SP) key constants for the Sureline app.
///
/// This file contains all the SharedPreferences key constants used
/// throughout the Sureline app for data persistence. The [SP] class
/// provides centralized access to preference keys for consistent
/// data storage and retrieval.
///
/// Key Features:
/// - SharedPreferences key definitions
/// - Data persistence constants
/// - App group storage keys
/// - User preference keys
/// - Notification settings keys
///
/// Usage:
/// ```dart
/// // Access theme preference key
/// String themeKey = SP.theme;
///
/// // Access volume setting key
/// String volumeKey = SP.volume;
///
/// // Store user preference
/// await prefs.setString(SP.theme, 'dark');
/// ```

/// SharedPreferences key constants class.
///
/// This class defines all the SharedPreferences keys used throughout
/// the Sureline app for data persistence. It provides a centralized
/// location for preference key management and ensures consistency
/// across the application.
///
/// Responsibilities:
/// - Define SharedPreferences key constants
/// - Organize keys by functionality
/// - Support data persistence operations
/// - Enable app group data sharing
///
/// Key Categories:
/// - Theme and appearance settings
/// - Audio and voice settings
/// - User onboarding and preferences
/// - Streak and gamification data
/// - Notification settings
/// - App group data sharing
class SP {
  /// Theme-related preference keys.
  ///
  /// Used for storing user theme preferences and settings.
  static const String theme = 'theme';
  static const String themes = 'themes';

  /// Audio-related preference keys.
  ///
  /// Used for storing volume and voice settings.
  static const String volume = 'volume';
  static const String voice = 'voice';

  /// User onboarding and interaction preference keys.
  ///
  /// Used for tracking user onboarding completion and interaction preferences.
  static const String onboarding = 'onboarding';
  static const String swipe = 'swipe';

  /// User engagement preference keys.
  ///
  /// Used for tracking user likes and engagement metrics.
  static const String likeCount = 'like_count';

  /// User guide preference keys.
  ///
  /// Used for tracking whether users have seen various app guides.
  static const String shareGuide = 'share_guide';
  static const String likeGuide = 'like_guide';

  /// Feed setup preference key.
  ///
  /// Used for storing user feed configuration settings.
  static const String feedSetup = 'feed_setup';

  /// Streak-related preference keys.
  ///
  /// Used for storing user streak data and achievements.
  static const String streakData = 'streak_data';
  static const String streakDataArchive = 'streak_data_archive';

  /// User preference keys.
  ///
  /// Used for storing user personalization preferences.
  static const String authorPreferences = 'author_preferences';
  static const String mutedContent = 'muted_content';
  static const String genderIdentities = 'gender_identities';

  /// User profile preference keys.
  ///
  /// Used for storing user profile information and settings.
  static const String name = 'name';
  static const String streakEnable = 'streak_enable';

  /// Notification-related preference keys.
  ///
  /// Used for storing notification settings and user preferences.
  static const String hasShownNotificationLimitDialog = 'has_shown_notification_limit_dialog';

  /// App group data sharing keys.
  ///
  /// Used for sharing data between the main app and iOS widget extensions.
  static const String quotesDataAppGroup = 'quotes_data_app_group';
  static const String textColorAppGroup = 'text_color_app_group';
  static const String textSizeAppGroup = 'text_size_app_group';
  static const String imageAssetAppGroup = 'image_asset_app_group';
  static const String solidColorAppGroup = 'solid_color_app_group';

  /// Notification scheduling preference keys.
  ///
  /// Used for storing notification scheduling data and user preferences.
  static const String lastNotificationScheduledAt = 'last_notification_scheduled_at';
  static const String notificationUserPrefs = 'notification_user_prefs';
  static const String notificationPresets = 'notification_presets';

  /// User content preference keys.
  ///
  /// Used for storing user-generated content and preferences.
  static const String likedQuotes = 'liked_quotes';
  static const String ownQuotes = 'own_quotes';
  // static const String collections = 'collections';
}
