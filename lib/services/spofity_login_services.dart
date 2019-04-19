import 'dart:async';
import 'dart:convert';

import 'package:gdg_girona_spotify_flutter_app/helpers/SecretLoader.dart';
import 'package:gdg_girona_spotify_flutter_app/models/SpotifyTokens.dart';
import 'package:http/http.dart';

class SpotifyLoginService {
  dynamic _extractData(Response resp) => json.decode(resp.body);

  Future<SpotifyTokens> getTokens(String code) async {
    var url = 'https://accounts.spotify.com/api/token';
    var secrets = await SecretLoader().load();
    var response = await post(
      url,
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': 'https://example.com/callback',
        'client_id': secrets.clientId,
        'client_secret': secrets.clientSecret,
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final spotifyTokens = SpotifyTokens.fromJson(_extractData(response));

    print("access token:");
    print(spotifyTokens.access_token);
    return spotifyTokens;
  }

  Future<SpotifyTokens> getNewToken(String refreshToken) async {
    var url = 'https://accounts.spotify.com/api/token';
    var secrets = await SecretLoader().load();
    var response = await post(
      url,
      body: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
        'client_id': secrets.clientId,
        'client_secret': secrets.clientSecret,
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final spotifyTokens = SpotifyTokens.fromJson(_extractData(response));

    print("access token:");
    print(spotifyTokens.access_token);
    return spotifyTokens;
  }
}
