/// Base class for all category events.
/// All events that can be dispatched to the CategoryBloc
/// must extend this class to ensure type safety.
abstract class CategoryEvent {
  const CategoryEvent();
}

/// Event to retrieve all available quote categories.
/// This event is dispatched to load the list of categories
/// that users can select from during onboarding.
class GetCategories extends CategoryEvent {
  const GetCategories();
}
