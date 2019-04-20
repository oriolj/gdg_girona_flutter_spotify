import 'package:flutter/material.dart';
import 'package:gdg_girona_spotify_flutter_app/models/SpotifyArtist.dart';
import 'package:url_launcher/url_launcher.dart';


class SpotifyArtistWidget extends StatelessWidget {
  final SpotifyArtist artist;

  SpotifyArtistWidget(this.artist, {Key key}) : super(key: key);

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: FadeInImage.assetNetwork(
              placeholder: "assets/loading.gif",
              image: artist.mainImage,
            ),
            title: Text(artist.name),
            subtitle: Text("Followers: ${artist.followers}, Popularity: ${artist
                .popularity}"),
          ),
          ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {

                  },
                ),
                FlatButton(
                  child: const Text('LISTEN'),
                  onPressed: () {
                    _launchURL(artist.spotifyUrl);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
