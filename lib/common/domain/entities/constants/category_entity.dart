/// Category-related domain entities for the Sureline app.
///
/// This file contains the domain entity for handling category data
/// within the Sureline app. The [CategoryEntity] represents a category
/// that can be used for organizing and filtering quotes, with support
/// for selection state tracking.
///
/// Key Features:
/// - Immutable category data structure
/// - Selection state tracking
/// - Factory method for model conversion
/// - CopyWith method for immutable updates
///
/// Usage:
/// ```dart
/// final category = CategoryEntity(
///   title: 'Motivation',
///   isSelected: true,
/// );
/// ```

import 'package:sureline/features/onboarding/interested_catag/data/model/category_model.dart';

/// Entity representing a category for organizing quotes.
///
/// This entity is used for managing categories that help organize
/// and filter quotes within the app. It tracks the category title
/// and whether it has been selected by the user.
///
/// Properties:
/// - [title]: The display name of the category
/// - [isSelected]: Whether this category has been selected by the user
///
/// The entity is immutable and provides factory methods for converting
/// from data models to domain entities, as well as a copyWith method
/// for creating modified instances.
class CategoryEntity {
  /// The display name of the category.
  ///
  /// Human-readable name that identifies this category,
  /// such as "Motivation", "Success", "Happiness", etc.
  final String title;

  /// Whether this category has been selected by the user.
  ///
  /// True if the user has selected this category for their preferences
  /// or filtering purposes. Defaults to false.
  final bool isSelected;

  /// Creates a [CategoryEntity] instance.
  ///
  /// [title] is required to create a category.
  /// [isSelected] is optional and defaults to false.
  ///
  /// [title]: The display name of the category
  /// [isSelected]: Whether this category is selected (defaults to false)
  const CategoryEntity({required this.title, this.isSelected = false});

  /// Creates a copy of this entity with the given fields replaced by new values.
  ///
  /// This method allows for immutable updates by creating a new instance
  /// with only the specified fields changed.
  ///
  /// All parameters are optional. If not provided, the current value is used.
  /// Returns: A new [CategoryEntity] instance with updated values
  CategoryEntity copyWith({String? title, bool? isSelected}) {
    return CategoryEntity(title: title ?? this.title, isSelected: isSelected ?? this.isSelected);
  }

  /// Creates a [CategoryEntity] from a [CategoryModel].
  ///
  /// This factory method converts a data layer model to a domain entity,
  /// maintaining the separation between data and domain layers.
  ///
  /// [model]: The data model to convert from
  /// Returns: A new [CategoryEntity] instance
  factory CategoryEntity.fromModel(CategoryModel model) {
    return CategoryEntity(title: model.title, isSelected: model.isSelected);
  }
}
