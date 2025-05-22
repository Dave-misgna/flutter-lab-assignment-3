import 'dart:convert';

import 'package:flutter_lab_assignment_3/data/model/album.dart';
import 'package:flutter_lab_assignment_3/data/model/photo.dart';
import 'package:flutter_lab_assignment_3/data/service/api_service.dart';

class AlbumRepository {
  Future<List<Album>> fetchAlbums() async {
    final response = await HttpClient.get('/albums');
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Album.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<Photo>> fetchPhotos(int albumId) async {
    final response = await HttpClient.get('/photos?albumId=$albumId');
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Photo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}