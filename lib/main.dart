import 'package:flutter/material.dart';
import 'package:gdg_girona_spotify_flutter_app/screens/login_screen.dart';
import 'package:gdg_girona_spotify_flutter_app/screens/search_artist_screen.dart';
import 'package:gdg_girona_spotify_flutter_app/services/UserService.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserService userService = UserService();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify Flutter GDG Girona',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FutureBuilder(
        future: userService.isLogged(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var isLogged = snapshot.data;
            if (isLogged) {
              print("Already logged");
              return SearchArtistScreen();
            } else {
              print("Not yet logged");
              return NonLoggedScreen();
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class NonLoggedScreen extends StatelessWidget {
  NonLoggedScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen();
  }
}
