import 'package:sureline/features/onboarding/interested_catag/domain/entity/category_entity.dart';

/// Data model for quote categories in the data layer.
/// This model extends CategoryEntity and provides the data layer representation
/// for category configurations used in the interested categories feature.
///
/// The model maintains the same structure as the domain entity,
/// ensuring proper data flow between layers.
class CategoryModel extends CategoryEntity {
  CategoryModel({required super.title, super.isSelected});
}
