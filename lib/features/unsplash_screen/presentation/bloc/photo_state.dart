import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';

abstract class PhotoState {
  const PhotoState();
}

class Initial extends PhotoState{}

class GettingPhotos extends PhotoState {
  GettingPhotos();
}

class GotPhotos extends PhotoState {
  final List<PhotoEntity> result;
  GotPhotos(this.result);
}

class SearchingPhotos extends PhotoState {
  SearchingPhotos();
}

class SearchedPhotos extends PhotoState {
  final List<PhotoEntity> result;
  SearchedPhotos(this.result);
}