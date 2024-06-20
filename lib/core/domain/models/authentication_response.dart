class AuthenticationResponse {
  final String token;
  final String email;
  final String role;

  AuthenticationResponse(
      this.token,
      this.email,
      this.role
      );

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticationResponse(
        json['token'],
        json['email'],
        json['role']
        );
  }
}