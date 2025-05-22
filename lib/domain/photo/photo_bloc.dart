import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/album_repository.dart';
import 'photo_event.dart';
import 'photo_state.dart';


class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final AlbumRepository albumRepository;

  PhotoBloc(this.albumRepository) : super(PhotoInitial()) {
    on<FetchPhotos>((event, emit) async {
      emit(PhotoLoading());
      try {
        final photos = await albumRepository.fetchPhotos(event.albumId);
        emit(PhotoLoaded(photos));
      } catch (e) {
        emit(PhotoError('Failed to load photos. Please try again.'));
      }
    });
  }
}

