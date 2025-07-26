import 'package:sureline/common/domain/entities/collections/search_entity.dart';

/// Abstract base class for all search-related events.
///
/// This class serves as the foundation for all events that can be
/// dispatched to the SearchBloc. It ensures type safety and provides
/// a common interface for search event handling.
abstract class SearchEvent {
  const SearchEvent();
}

/// Event triggered when search text input changes.
///
/// This event is dispatched whenever the user types in the search field.
/// It includes the current query text and page number for pagination
/// support. The SearchBloc implements debouncing for this event to
/// optimize performance and reduce unnecessary API calls.
///
/// Properties:
/// - [query]: Current search text entered by user
/// - [page]: Page number for pagination (defaults to 1)
///
/// Usage:
/// ```dart
/// context.read<SearchBloc>().add(
///   OnSearchTextChanged(searchText, currentPage),
/// );
/// ```
class OnSearchTextChanged extends SearchEvent {
  /// The current search query text.
  final String query;

  /// The page number for pagination.
  final int page;

  /// Creates a new OnSearchTextChanged event.
  const OnSearchTextChanged(this.query, this.page);
}

/// Event to execute a search operation.
///
/// This event triggers the actual search functionality. It can be
/// dispatched directly or as a result of debounced text changes.
/// The search operation will retrieve quotes that match the query
/// and update the search results accordingly.
///
/// Properties:
/// - [query]: Search query to execute
/// - [page]: Page number for pagination
///
/// Usage:
/// ```dart
/// context.read<SearchBloc>().add(
///   SearchQuote(searchQuery, pageNumber),
/// );
/// ```
class SearchQuote extends SearchEvent {
  /// The search query to execute.
  final String query;

  /// The page number for pagination.
  final int page;

  /// Creates a new SearchQuote event.
  const SearchQuote(this.query, this.page);
}

/// Event triggered when user toggles favorite status.
///
/// This event handles the user interaction with the favorite button
/// on search result items. It toggles the favorite status of a quote
/// and updates the search results to reflect the change. The event
/// includes haptic feedback for better user experience.
///
/// Properties:
/// - [isLiked]: Whether the quote should be marked as favorite
/// - [entity]: The search entity (quote) to toggle favorite status
///
/// Usage:
/// ```dart
/// context.read<SearchBloc>().add(
///   OnLikePressed(
///     isLiked: !currentFavoriteStatus,
///     entity: searchEntity,
///   ),
/// );
/// ```
class OnLikePressed extends SearchEvent {
  /// Whether the quote should be marked as favorite.
  final bool isLiked;

  /// The search entity to toggle favorite status.
  final SearchEntity entity;

  /// Creates a new OnLikePressed event.
  const OnLikePressed({required this.isLiked, required this.entity});
}
