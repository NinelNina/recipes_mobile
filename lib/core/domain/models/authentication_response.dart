class AuthenticationResponse {
  final String token;

  AuthenticationResponse(this.token);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticationResponse(json['token']);
  }
}