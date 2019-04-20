import 'package:flutter/material.dart';
import 'package:gdg_girona_spotify_flutter_app/models/SpotifyArtist.dart';
import 'package:gdg_girona_spotify_flutter_app/services/UserService.dart';
import 'package:gdg_girona_spotify_flutter_app/services/spofity_search_services.dart';
import 'package:gdg_girona_spotify_flutter_app/widgets/SpotifyArtistWidget.dart';


class SearchArtistScreen extends StatelessWidget {
  SearchArtistScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = UserService();

    return FutureBuilder(
      future: userService.getAccessToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var accessToken = snapshot.data;
          return SearchArtistWidget(accessToken);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class SearchArtistWidget extends StatefulWidget {
  final String _accessToken;

  SearchArtistWidget(this._accessToken, {Key key}) : super(key: key);

  @override
  _SearchArtistWidgetState createState() =>
      _SearchArtistWidgetState(_accessToken);
}

class _SearchArtistWidgetState extends State<SearchArtistWidget> {
  final String _accessToken;
  SpotifySearchService spotifySearchService = SpotifySearchService();

  List<SpotifyArtist> searchResults = List<SpotifyArtist>();

  String _searchText = "";
  TextEditingController controller = TextEditingController();

  _SearchArtistWidgetState(this._accessToken);

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
//      if (_searchText.length < 3) return;
      _searchText = controller.text;
      updateResults(_searchText);
    });

    return Scaffold(
      appBar: AppBar(title: Text("Search Artist")),
      body: Column(
        children: <Widget>[
          TextField(
            controller: controller,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return SpotifyArtistWidget(searchResults[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  updateResults(String searchText) async {
    var results = await spotifySearchService.searchArtist(_accessToken, _searchText);
    setState(() {
      searchResults = results;
    });
  }
}
