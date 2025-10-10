import 'package:sureline/common/domain/entities/collections/search_entity.dart';

/// Abstract base class for all search-related states.
///
/// This class serves as the foundation for all states that can be
/// emitted by the SearchBloc. It ensures type safety and provides
/// a common interface for search state handling in the UI layer.
abstract class SearchState {
  const SearchState();
}

/// Initial state when no search has been performed.
///
/// This state represents the default state of the search functionality
/// before any user interaction. It indicates that no search operation
/// has been initiated and the search results are empty.
///
/// Usage:
/// ```dart
/// if (state is Initial) {
///   // Show empty search state or placeholder
/// }
/// ```
class Initial extends SearchState {
  const Initial();
}

/// State when search operation is in progress.
///
/// This state is emitted when a search operation is being executed.
/// It indicates that the system is actively searching for quotes
/// that match the user's query. The UI should show a loading indicator
/// during this state to provide user feedback.
///
/// Usage:
/// ```dart
/// if (state is SearchingQuotes) {
///   // Show loading indicator
///   return CircularProgressIndicator();
/// }
/// ```
class SearchingQuotes extends SearchState {
  const SearchingQuotes();
}

/// State when search results have been successfully retrieved.
///
/// This state is emitted when the search operation completes successfully
/// and results are available. It contains the list of search entities
/// that match the user's query, including their favorite status and
/// collection associations.
///
/// Properties:
/// - [result]: List of search entities (quotes) that match the query
///
/// Usage:
/// ```dart
/// if (state is SearchedQuotes) {
///   // Display search results
///   return ListView.builder(
///     itemCount: state.result.length,
///     itemBuilder: (context, index) => SearchResultItem(
///       entity: state.result[index],
///     ),
///   );
/// }
/// ```
class SearchedQuotes extends SearchState {
  /// The search results containing matching quotes.
  final List<SearchEntity> result;

  /// Creates a new SearchedQuotes state.
  const SearchedQuotes(this.result);
}

/// State when search data has been loaded and is ready for display.
///
/// This state is emitted when search data has been successfully loaded
/// and is ready to be displayed to the user. It represents a stable
/// state where all search results are available and the UI can render
/// them without any loading indicators.
///
/// Properties:
/// - [result]: List of search entities ready for display
///
/// Usage:
/// ```dart
/// if (state is GotSearch) {
///   // Display search results with full functionality
///   return SearchResultsView(results: state.result);
/// }
/// ```
class GotSearch extends SearchState {
  /// The search results ready for display.
  final List<SearchEntity> result;

  /// Creates a new GotSearch state.
  const GotSearch(this.result);
}
