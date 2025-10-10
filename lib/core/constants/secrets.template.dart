/// Template for secrets and sensitive configuration values.
///
/// Copy this file to `secrets.dart` and replace the placeholder values with your actual secrets.
/// The `secrets.dart` file is ignored by git to prevent committing sensitive data.

class Secrets {
  /// FlagSmith API key for feature flag service.
  ///
  /// Used for remote configuration and feature flag management.
  /// Get this from your FlagSmith dashboard.
  static const String flagSmithApiKey = String.fromEnvironment(
    'FLAGSMITH_API_KEY',
    defaultValue: 'your_flagsmith_api_key_here',
  );

  /// Superwall API key for paywall management.
  ///
  /// Used for in-app purchase and subscription management.
  /// Get this from your Superwall dashboard.
  static const String superwallApiKey = String.fromEnvironment(
    'SUPERWALL_API_KEY',
    defaultValue: 'your_superwall_api_key_here',
  );

  /// Canny private key for SSO token generation.
  ///
  /// Used for user authentication in Canny feedback platform.
  /// Get this from your Canny dashboard.
  static const String cannyPrivateKey = String.fromEnvironment(
    'CANNY_PRIVATE_KEY',
    defaultValue: 'your_canny_private_key_here',
  );

  /// Canny board token for feedback platform.
  ///
  /// Used for identifying the specific board in Canny feedback platform.
  /// Get this from your Canny dashboard.
  static const String cannyBoardToken = String.fromEnvironment(
    'CANNY_BOARD_TOKEN',
    defaultValue: 'your_canny_board_token_here',
  );

  /// Facebook App ID for social sharing.
  ///
  /// Used for Facebook integration and social sharing features.
  /// Get this from your Facebook Developer Console.
  static const String facebookAppId = String.fromEnvironment(
    'FACEBOOK_APP_ID',
    defaultValue: 'your_facebook_app_id_here',
  );

  /// Facebook Client Token for social sharing.
  ///
  /// Used for Facebook integration and social sharing features.
  /// Get this from your Facebook Developer Console.
  static const String facebookClientToken = String.fromEnvironment(
    'FACEBOOK_CLIENT_TOKEN',
    defaultValue: 'your_facebook_client_token_here',
  );

  /// TikTok Client Key for social sharing.
  ///
  /// Used for TikTok integration and social sharing features.
  /// Get this from your TikTok Developer Console.
  static const String tiktokClientKey = String.fromEnvironment(
    'TIKTOK_CLIENT_KEY',
    defaultValue: 'your_tiktok_client_key_here',
  );

  /// RevenueCat API key for subscription management.
  ///
  /// Used for in-app purchase and subscription tracking.
  /// Get this from your RevenueCat dashboard.
  static const String revenueCatApiKey = String.fromEnvironment(
    'REVENUECAT_API_KEY',
    defaultValue: 'appl_oWEwpLqIPkFqyPzUaxSNJEspuBY',
  );

  /// Default user email for Canny SSO.
  ///
  /// Used as the default email for user authentication in Canny feedback platform.
  /// This should be replaced with actual user email in production.
  static const String defaultUserEmail = String.fromEnvironment(
    'DEFAULT_USER_EMAIL',
    defaultValue: 'your_default_user_email_here',
  );

  /// Add other secrets here as needed
  /// Example:
  /// static const String someOtherSecret = String.fromEnvironment(
  ///   'SOME_OTHER_SECRET',
  ///   defaultValue: 'your_secret_here',
  /// );
}
