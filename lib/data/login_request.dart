import '../auth/login_type.dart';

class LoginRequest {
  final LoginType loginType;
  final String socialToken;

  LoginRequest({
    required this.loginType,
    required this.socialToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'certificationSubject': loginType.getDisplayName(),
      'socialToken': socialToken,
    };
  }

  @override
  String toString() {
    return 'LoginRequest{loginType: $loginType, socialToken: $socialToken}';
  }
}
