import 'dart:async';

import 'package:gdg_girona_spotify_flutter_app/models/SpotifyTokens.dart';
import 'package:gdg_girona_spotify_flutter_app/services/spofity_login_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<bool> isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("refresh_token") &&
        prefs.containsKey("access_token") &&
        prefs.getString("access_token").length > 1;
  }

  Future<bool> isAccessTokenExpired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var expireAtSecond = prefs.getInt("expires_at");
    var currentTsSecond =
        (num.parse(DateTime.now().millisecondsSinceEpoch.toStringAsFixed(0)));
    return currentTsSecond > expireAtSecond;
  }

  Future<Null> saveTokenInfo(SpotifyTokens tokens) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (tokens.refresh_token != null && tokens.refresh_token.length > 1) {
      await prefs.setString("refresh_token", tokens.refresh_token);
    }
    await prefs.setString("access_token", tokens.access_token);
    var currentTsSecond =
        (num.parse(DateTime.now().millisecondsSinceEpoch.toStringAsFixed(0)));
    await prefs.setInt("expires_at", currentTsSecond + tokens.expires_in);
  }

  Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _expired = await isAccessTokenExpired();

    if (_expired) {
      SpotifyLoginService spotifyLoginService = SpotifyLoginService();
      saveTokenInfo(
          await spotifyLoginService.getNewToken(await getRefreshToken()));
    }
    return prefs.getString("access_token");
  }

  Future<String> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("refresh_token");
  }
}
