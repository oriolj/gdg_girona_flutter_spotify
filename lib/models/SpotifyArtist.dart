class SpotifyArtist {
  String id;
  String name;
  String mainImage;
  String spotifyUrl;
  int followers;

  int popularity;

  SpotifyArtist(
    this.id,
    this.name,
    this.popularity,
    this.mainImage,
    this.spotifyUrl,
    this.followers,
  );

  factory SpotifyArtist.fromJson(Map<String, dynamic> item) {
    var mainImage = "https://placeimg.com/640/480/people";
    var externalUrl = "";
    if (item['images'].length > 0 && item['images'][0] != null) {
      mainImage = item['images'][0]['url'];
    }
    if (item['external_urls']['spotify'] != null) {
      externalUrl = item['external_urls']['spotify'];
    }
    return SpotifyArtist(
      item['id'],
      item['name'],
      _toInt(item['popularity']),
      mainImage,
      externalUrl,
      _toInt(item['followers']['total']),
    );
  }
}

int _toInt(id) => id is int ? id : int.parse(id);
