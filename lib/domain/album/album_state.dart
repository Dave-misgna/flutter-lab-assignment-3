import 'package:flutter_lab_assignment_3/data/model/album.dart';

abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  AlbumLoaded(this.albums);
}

class AlbumError extends AlbumState {
  final String message;
  AlbumError(this.message);
}
