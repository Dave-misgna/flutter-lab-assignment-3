import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/album_repository.dart';
import 'router/app_router.dart';

import 'domain/album/album_bloc.dart';
import 'domain/album/album_event.dart';

void main() {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final albumRepository = AlbumRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AlbumBloc(albumRepository)..add(FetchAlbums()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Album App',
        theme: ThemeData(primarySwatch: Colors.blue),
        routerConfig: router,
      ),
    );
  }
}
