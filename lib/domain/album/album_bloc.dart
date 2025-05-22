
import '../../data/album_repository.dart';
import 'album_event.dart';
import 'album_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository albumRepository;

  AlbumBloc(this.albumRepository) : super(AlbumInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await albumRepository.fetchAlbums();
        emit(AlbumLoaded(albums));
      } catch (e) {
        emit(AlbumError('Failed to load albums. Please try again.'));
      }
    });
  }
}
