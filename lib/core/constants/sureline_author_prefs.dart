/// Author preference constants for the Sureline app.
///
/// This file contains author-related constants and configurations
/// for user preferences within the Sureline app. The [SurelineAuthorPrefs]
/// class defines available authors and their preference settings.
///
/// Key Features:
/// - Author preference model definitions
/// - Locked and preferred author settings
/// - Author selection constants
/// - Preference management
///
/// Usage:
/// ```dart
/// // Access available authors
/// var authors = SurelineAuthorPrefs.values;
///
/// // Get preferred authors
/// var preferred = authors.where((a) => a.isPreferred);
/// ```

import 'package:sureline/features/preferenecs/general_settings/author_preferences/data/model/author_pref_model.dart';

/// Author preferences configuration class.
///
/// This class defines the available authors and their preference
/// settings for the Sureline app. It provides a centralized
/// location for author configurations and user preferences.
///
/// Responsibilities:
/// - Define available authors
/// - Configure author preference settings
/// - Manage locked and preferred authors
/// - Support author selection functionality
///
/// Author Settings:
/// - [isLocked]: Whether the author requires premium access
/// - [isPreferred]: Whether the author is marked as preferred by default
class SurelineAuthorPrefs {
  /// List of available authors with their preference settings.
  ///
  /// Contains author configurations with names, lock status, and
  /// preference settings for personalization and content filtering.
  ///
  /// Available Authors:
  /// - Napoleon Hill: Unlocked, preferred by default
  /// - Jim Collins: Unlocked, preferred by default
  /// - Peter Drucker: Locked (requires premium)
  ///
  /// Usage:
  /// ```dart
  /// // Get all available authors
  /// var authors = SurelineAuthorPrefs.values;
  ///
  /// // Get unlocked authors
  /// var unlocked = authors.where((a) => !a.isLocked);
  ///
  /// // Get preferred authors
  /// var preferred = authors.where((a) => a.isPreferred);
  /// ```
  static final List<AuthorPrefModel> values = [
    AuthorPrefModel(authorName: 'Napoleon Hill', isPreferred: true, isPremium: false),
    AuthorPrefModel(authorName: 'Jim Collins', isPreferred: true, isPremium: false),
    AuthorPrefModel(authorName: 'Peter Drucker', isPreferred: true, isPremium: false),
    AuthorPrefModel(authorName: 'James Clear', isPreferred: true, isPremium: true),
  ];
}
