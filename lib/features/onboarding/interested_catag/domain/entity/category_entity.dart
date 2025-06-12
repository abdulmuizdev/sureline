import 'package:sureline/features/onboarding/interested_catag/data/model/category_model.dart';

class CategoryEntity {
  final String title;
  final bool isSelected;

  const CategoryEntity({required this.title, this.isSelected = false});

  CategoryEntity copyWith({String? title, bool? isSelected}) {
    return CategoryEntity(
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory CategoryEntity.fromModel(CategoryModel model) {
    return CategoryEntity(title: model.title, isSelected: model.isSelected);
  }
}
