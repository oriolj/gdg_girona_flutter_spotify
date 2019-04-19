class SpotifyArtist {
  String id;
  String name;

  int popularity;

  SpotifyArtist(
    this.id,
    this.name,
    this.popularity,
  );

  factory SpotifyArtist.fromJson(Map<String, dynamic> item) =>
      new SpotifyArtist(
        item['id'],
        item['name'],
        _toInt(item['popularity']),
      );
}

int _toInt(id) => id is int ? id : int.parse(id);
