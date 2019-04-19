import 'dart:async';

import 'package:gdg_girona_spotify_flutter_app/models/SpotifyTokens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<bool> isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("refresh_token");
  }

  Future<bool> isAccessTokenExpired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var expireAtSecond = prefs.getInt("expires_at");
    var currentTsSecond = (num.parse(DateTime.now().millisecondsSinceEpoch.toStringAsFixed(0)));
    return currentTsSecond > expireAtSecond;
  }

  Future<Null> saveTokenInfo(SpotifyTokens tokens) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (tokens.refresh_token.length > 1) {
      prefs.setString("refresh_token", tokens.refresh_token);
    }
    prefs.setString("access_token", tokens.access_token);
    var currentTsSecond = (num.parse(DateTime.now().millisecondsSinceEpoch.toStringAsFixed(0)));
    prefs.setInt("expires_at", currentTsSecond + tokens.expires_in);
  }

  Future<Null> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_token");
  }

  Future<Null> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("refresh_token");
  }
}
