import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';

/// Base class for photo-related states.
/// All photo bloc states must extend this class.
abstract class PhotoState {
  const PhotoState();
}

/// Initial state before any photo operations.
class Initial extends PhotoState {}

/// State emitted while loading photos.
/// Indicates loading operation in progress.
class GettingPhotos extends PhotoState {
  GettingPhotos();
}

/// State emitted when photos are successfully loaded.
/// Contains the list of retrieved photos.
class GotPhotos extends PhotoState {
  /// List of retrieved photos
  final List<PhotoEntity> result;
  GotPhotos(this.result);
}

/// State emitted while searching photos.
/// Indicates search operation in progress.
class SearchingPhotos extends PhotoState {
  SearchingPhotos();
}

/// State emitted when photo search is completed.
/// Contains the list of search results.
class SearchedPhotos extends PhotoState {
  /// List of search result photos
  final List<PhotoEntity> result;
  SearchedPhotos(this.result);
}
