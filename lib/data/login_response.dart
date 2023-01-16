class LoginResponse {
  final int id;
  final String name;
  final String certificationSubject;
  final bool notificationConsent;
  final Map<String, dynamic> resource;
  final LoginToken token;

  LoginResponse({
    required this.id,
    required this.name,
    required this.certificationSubject,
    required this.notificationConsent,
    required this.resource,
    required this.token,
  });

  static LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      certificationSubject: json['certificationSubject'] as String,
      notificationConsent: json['notificationConsent'] as bool,
      resource: json['resource'],
      token: LoginToken.fromJson(json['token']),
    );
  }

  @override
  String toString() {
    return 'LoginResponse{id: $id, name: $name, certificationSubject: $certificationSubject, notificationConsent: $notificationConsent, resource: $resource, token: $token}';
  }
}

class LoginToken {
  final String accessToken;
  final String refreshToken;

  LoginToken({
    required this.accessToken,
    required this.refreshToken,
  });

  static LoginToken fromJson(Map<String, dynamic> json) {
    return LoginToken(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  @override
  String toString() {
    return 'LoginToken{accessToken: $accessToken, refreshToken: $refreshToken}';
  }
}
