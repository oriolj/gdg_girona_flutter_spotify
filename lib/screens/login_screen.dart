import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gdg_girona_spotify_flutter_app/helpers/SecretLoader.dart';
import 'package:gdg_girona_spotify_flutter_app/services/UserService.dart';
import 'package:gdg_girona_spotify_flutter_app/services/spofity_login_services.dart';

// https://pub.dartlang.org/packages/flutter_webview_plugin#-readme-tab-

class SignInScreen extends StatelessWidget {
  SignInScreen({Key key}) : super(key: key);

  registerTokens(String code) async {
    final SpotifyLoginService spotifyLoginService = SpotifyLoginService();
    final UserService userService = UserService();

    var tokens = await spotifyLoginService.getTokens(code);
    userService.saveTokenInfo(tokens);
  }

  @override
  Widget build(BuildContext context) {

    final flutterWebviewPlugin = new FlutterWebviewPlugin();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print("loading url: $url");
      if (url.startsWith("https://example.com/callback")) {
        flutterWebviewPlugin.stopLoading();
        var code = url.split("code=")[1];
        registerTokens(code);
      }
    });

    var secrets = SecretLoader().load();


    return FutureBuilder(
      future: secrets,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var cid = snapshot.data.clientId;
          var spotifyUrlLogin = "https://accounts.spotify.com/authorize?client_id=$cid&response_type=code&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback";

          return WebviewScaffold(
            url: spotifyUrlLogin,
            appBar: AppBar(
              title: const Text('Login on Spotify'),
            ),
            withZoom: false,
            withLocalStorage: true,
            hidden: true,
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: Text('Cargando.....'),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
