import 'package:sureline/features/onboarding/interested_catag/domain/entity/category_entity.dart';

/// Base class for all category states.
/// All states that can be emitted by the CategoryBloc
/// must extend this class to ensure type safety.
abstract class CategoryState {
  const CategoryState();
}

/// Initial state when the category feature is first loaded.
/// This state is emitted before any category data is loaded or operations are performed.
class Initial extends CategoryState {
  const Initial();
}

/// State emitted while categories are being retrieved.
/// This state indicates that the category loading operation is in progress.
class GettingCategories extends CategoryState {
  const GettingCategories();
}

/// State emitted when categories have been successfully retrieved.
/// This state contains the list of available categories that users can select from.
///
/// [result] - List of category entities retrieved from storage
class GotCategories extends CategoryState {
  final List<CategoryEntity> result;

  const GotCategories(this.result);
}

/// State emitted when an error occurs during category operations.
/// This state contains error information for debugging and user feedback.
///
/// [message] - Error message describing what went wrong
class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);
}
