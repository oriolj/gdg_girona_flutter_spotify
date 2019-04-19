class SpotifyTokens {
  String access_token;
  String refresh_token;

  String token_type;
  String scope;
  int expires_in;

  SpotifyTokens(
    this.expires_in,
    this.scope,
    this.token_type,
    this.refresh_token,
    this.access_token,
  );

  factory SpotifyTokens.fromJson(Map<String, dynamic> item) =>
      new SpotifyTokens(
        _toInt(item['expires_in']),
        item['scope'],
        item['token_type'],
        item['refresh_token'],
        item['access_token'],
      );
}

int _toInt(id) => id is int ? id : int.parse(id);
