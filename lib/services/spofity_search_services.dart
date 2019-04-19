import 'dart:async';
import 'dart:convert';

import 'package:gdg_girona_spotify_flutter_app/models/SpotifyArtist.dart';
import 'package:http/http.dart';

class SpotifySearchService {
  dynamic _extractData(Response resp) => json.decode(resp.body);

  Future<List<SpotifyArtist>> searchArtist(String token, String query) async {
    var url = 'https://api.spotify.com/v1/search?q=$query&type=artist';

    var response = await get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': "application/json",
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final artistsList = (_extractData(response)["artists"]["items"] as List)
        .map((value) => SpotifyArtist.fromJson(value))
        .toList();

    return artistsList;
  }

}
