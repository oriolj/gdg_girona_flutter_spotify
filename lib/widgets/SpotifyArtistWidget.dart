import 'package:flutter/material.dart';
import 'package:gdg_girona_spotify_flutter_app/models/SpotifyArtist.dart';


class SpotifyArtistWidget extends StatelessWidget {
  final SpotifyArtist artist;

  SpotifyArtistWidget(this.artist, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(artist.name));
  }
}
