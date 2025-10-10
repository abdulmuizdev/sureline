/// Base class for photo-related events.
/// All photo bloc events must extend this class.
abstract class PhotoEvent {
  const PhotoEvent();
}

/// Event to retrieve photos from Unsplash.
/// Triggers photo loading with pagination support.
class GetPhotos extends PhotoEvent {
  const GetPhotos();
}

/// Event to search photos with query.
/// Triggers photo search with specific search term.
class SearchPhotos extends PhotoEvent {
  /// Search query for photo filtering
  final String query;
  const SearchPhotos(this.query);
}

/// Event for scroll position tracking.
/// Used for pagination and infinite scroll functionality.
class OnScrollPositionChange extends PhotoEvent {
  /// Current scroll position in pixels
  final double scrolledPixels;

  /// Maximum scroll extent in pixels
  final double maxScrollExtent;
  const OnScrollPositionChange(this.scrolledPixels, this.maxScrollExtent);
}

/// Event to listen to search controller changes.
/// Handles real-time search input with debouncing.
class ListenSearchController extends PhotoEvent {
  /// Current search query from controller
  final String query;
  const ListenSearchController(this.query);
}
