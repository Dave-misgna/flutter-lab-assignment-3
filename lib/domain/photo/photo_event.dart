
abstract class PhotoEvent {}

class FetchPhotos extends PhotoEvent {
  final int albumId;
  FetchPhotos(this.albumId);
}
