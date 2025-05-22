
import 'package:go_router/go_router.dart';

import '../data/model/album.dart';
import '../screen/album_detail_screen.dart';
import '../screen/album_list_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AlbumListScreen(),
    ),
    GoRoute(
      path: '/album',
      builder: (context, state) {
        final album = state.extra as Album;
        return AlbumDetailScreen(album: album);
      },
    ),
  ],
);