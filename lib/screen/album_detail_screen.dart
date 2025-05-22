import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/album_repository.dart';
import '../domain/photo/photo_bloc.dart';
import '../domain/photo/photo_event.dart';
import '../domain/photo/photo_state.dart';
import '../data/model/album.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Album album;

  const AlbumDetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhotoBloc(AlbumRepository())..add(FetchPhotos(album.id)),
      child: Scaffold(
        appBar: AppBar(title: Text(album.title)),
        body: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            if (state is PhotoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PhotoLoaded && state.photos.isNotEmpty) {
              final photo = state.photos.first; // Get the first photo
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          photo.thumbnailUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 300,
                              height: 300,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported, size: 50),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        photo.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is PhotoError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PhotoBloc>().add(FetchPhotos(album.id));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('No photo found.'));
          },
        ),
      ),
    );
  }
}