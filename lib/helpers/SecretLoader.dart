import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;
import 'package:gdg_girona_spotify_flutter_app/helpers/Secret.dart';

class SecretLoader {
  final String secretPath;

  SecretLoader({
    this.secretPath = "secrets.json",
  });

  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(this.secretPath,
        (jsonStr) async {
      final secret = Secret.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}
