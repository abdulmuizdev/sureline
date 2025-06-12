abstract class PhotoEvent {
  const PhotoEvent();
}

class GetPhotos extends PhotoEvent {
  const GetPhotos();
}

class SearchPhotos extends PhotoEvent {
  final String query;
  const SearchPhotos(this.query);
}

class OnScrollPositionChange extends PhotoEvent {
  final double scrolledPixels;
  final double maxScrollExtent;
  const OnScrollPositionChange(this.scrolledPixels, this.maxScrollExtent);
}

class ListenSearchController extends PhotoEvent {
  final String query;

  const ListenSearchController(this.query);
}