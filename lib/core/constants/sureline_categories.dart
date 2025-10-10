/// Category constants for the Sureline app.
///
/// This file contains category configurations for quote organization
/// and user preferences within the Sureline app. The [SurelineCategories]
/// class defines available categories for quote filtering and personalization.
///
/// Key Features:
/// - Quote category definitions
/// - Personalization categories
/// - User preference categories
/// - Content organization
///
/// Usage:
/// ```dart
/// // Access available categories
/// var categories = SurelineCategories.values;
///
/// // Find specific category
/// var growthCategory = categories.firstWhere((c) => c.title == 'Personal Growth');
/// ```

import 'package:sureline/features/onboarding/interested_catag/data/model/category_model.dart';

/// Category configuration class for the Sureline app.
///
/// This class defines the available categories for quote organization
/// and user personalization in the Sureline app. It provides a
/// centralized location for category management and user preferences.
///
/// Responsibilities:
/// - Define available quote categories
/// - Support user personalization
/// - Enable content filtering
/// - Organize quote content
///
/// Category Focus Areas:
/// - Personal development and growth
/// - Mental health and wellness
/// - Self-improvement and confidence
/// - Mindfulness and gratitude
/// - Neurodiversity support
class SurelineCategories {
  /// List of available category configurations.
  ///
  /// Contains category models for organizing and filtering quotes
  /// based on different themes and user interests. These categories
  /// help users find relevant content and personalize their experience.
  ///
  /// Available Categories:
  /// - Personal Growth: Development and improvement quotes
  /// - Self-love: Self-acceptance and self-care quotes
  /// - Overthinking: Quotes to help with overthinking
  /// - Anxiety: Anxiety relief and calming quotes
  /// - Morning: Morning motivation and inspiration
  /// - Dream Big: Aspiration and goal-setting quotes
  /// - Neurodiversity: Support for neurodivergent individuals
  /// - Confidence: Self-confidence and empowerment quotes
  /// - Purpose: Life purpose and meaning quotes
  /// - Gratitude: Thankfulness and appreciation quotes
  ///
  /// Usage:
  /// ```dart
  /// // Get all available categories
  /// var categories = SurelineCategories.values;
  ///
  /// // Find specific category
  /// var growthCategory = categories.firstWhere((c) => c.title == 'Personal Growth');
  /// var anxietyCategory = categories.firstWhere((c) => c.title == 'Anxiety');
  ///
  /// // Filter by theme
  /// var mentalHealthCategories = categories.where((c) =>
  ///   ['Anxiety', 'Overthinking'].contains(c.title));
  /// ```
  static final List<CategoryModel> values = [
    CategoryModel(title: 'Personal Growth'),
    CategoryModel(title: 'Self-love'),
    CategoryModel(title: 'Overthinking'),
    CategoryModel(title: 'Anxiety'),
    CategoryModel(title: 'Morning'),
    CategoryModel(title: 'Dream Big'),
    CategoryModel(title: 'Neurodiversity'),
    CategoryModel(title: 'Confidence'),
    CategoryModel(title: 'Purpose'),
    CategoryModel(title: 'Gratitude'),
  ];
}
