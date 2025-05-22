class Album {
  final int id;
  final String title;

  Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) =>
      Album(id: json['id'], title: json['title']);
}
