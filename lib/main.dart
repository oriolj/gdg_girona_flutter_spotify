import 'package:flutter/material.dart';
import 'package:gdg_girona_spotify_flutter_app/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
//      home: NonLoggedScreen(),
      home: LoggedScreen(),
    );
  }
}

class LoggedScreen extends StatelessWidget {
  LoggedScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen();
  }
}
class NonLoggedScreen extends StatelessWidget {
  NonLoggedScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GDG Spotify"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
//              color: Colors.green,
              onPressed: null,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              child: Text(
                'Login to Spotify',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
