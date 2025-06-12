import 'package:sureline/features/onboarding/interested_catag/domain/entity/category_entity.dart';

abstract class CategoryState {
  const CategoryState();
}

class Initial extends CategoryState {
  const Initial();
}

class GettingCategories extends CategoryState {
  const GettingCategories();
}

class GotCategories extends CategoryState {
  final List<CategoryEntity> result;

  const GotCategories(this.result);
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);
}