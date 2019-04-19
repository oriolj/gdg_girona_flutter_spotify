class Secret {
  final String clientId;
  final String clientSecret;

  Secret({
    this.clientId = "",
    this.clientSecret = "",
  });

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(
      clientId: jsonMap["client_id"],
      clientSecret: jsonMap["client_secret"],
    );
  }
}
