import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../domain/album/album_bloc.dart';
import '../domain/album/album_event.dart';
import '../domain/album/album_state.dart';
import '../data/album_repository.dart';
import '../domain/photo/photo_bloc.dart';
import '../domain/photo/photo_event.dart';
import '../domain/photo/photo_state.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoaded) {
            return ListView.builder(
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                final album = state.albums[index];
                return Card(
                  elevation: 4.0,
                  
                  child: BlocProvider(
                    create: (_) => PhotoBloc(AlbumRepository())..add(FetchPhotos(album.id)),
                    child: BlocBuilder<PhotoBloc, PhotoState>(
                      builder: (context, photoState) {
                        return ListTile(
                          leading: photoState is PhotoLoaded && photoState.photos.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    photoState.photos.first.thumbnailUrl,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.image_not_supported),
                                      );
                                    },
                                  ),
                                )
                              : Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.grey[300],
                                  child: const Center(child: CircularProgressIndicator()),
                                ),
                          title: Text(album.title),
                          onTap: () {
                            context.push('/album', extra: album);
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is AlbumError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AlbumBloc>().add(FetchAlbums());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No albums available.'));
          }
        },
      ),
    );
  }
}
