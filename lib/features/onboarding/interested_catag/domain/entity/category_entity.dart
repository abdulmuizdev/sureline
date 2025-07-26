import 'package:sureline/features/onboarding/interested_catag/data/model/category_model.dart';

/// Domain entity representing a quote category for user preference selection.
/// This entity encapsulates the information needed to display and manage
/// quote categories during the onboarding process.
///
/// Categories help personalize the user's quote experience by allowing
/// them to select topics that interest them most.
class CategoryEntity {
  /// The display name of the category (e.g., "Motivation", "Success", "Wisdom").
  /// Used for UI presentation and user interaction.
  final String title;

  /// Whether this category is currently selected by the user.
  /// Controls the visual state and determines which categories
  /// will be used for quote personalization.
  final bool isSelected;

  const CategoryEntity({required this.title, this.isSelected = false});

  /// Creates a copy of this entity with updated values.
  /// Used for immutable state updates in category selection.
  ///
  /// [title] - Optional new display name for the category
  /// [isSelected] - Optional new selection status
  CategoryEntity copyWith({String? title, bool? isSelected}) {
    return CategoryEntity(title: title ?? this.title, isSelected: isSelected ?? this.isSelected);
  }

  /// Creates a CategoryEntity from a CategoryModel.
  /// This factory method converts data models to domain entities.
  ///
  /// [model] - The data model to convert to a domain entity
  factory CategoryEntity.fromModel(CategoryModel model) {
    return CategoryEntity(title: model.title, isSelected: model.isSelected);
  }
}
