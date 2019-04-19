import 'package:flutter/material.dart';
import 'package:gdg_girona_spotify_flutter_app/services/UserService.dart';
import 'package:gdg_girona_spotify_flutter_app/services/spofity_search_services.dart';

// https://pub.dartlang.org/packages/flutter_webview_plugin#-readme-tab-

class SearchArtist extends StatelessWidget {
  SearchArtist({Key key}) : super(key: key);

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

  final items = List<String>.generate(10000, (i) => "Item $i");
  String _searchText = "";
  TextEditingController controller = TextEditingController();

  int _counter = 0;

  _SearchArtistWidgetState(this._accessToken);

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
//      if (_searchText.length < 3) return;
      _searchText = controller.text;
      setState(() {
        spotifySearchService.searchArtist(_accessToken, _searchText);
      });
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
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${items[index]}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
