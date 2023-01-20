import 'package:flutter/foundation.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:three_days/auth/session_repository.dart';

import '../data/three_days_api.dart';
import 'login_type.dart';

class LoginRepository {
  final ThreeDaysApi threeDaysApi;
  final SessionRepository sessionRepository;

  LoginRepository({
    required this.threeDaysApi,
    required this.sessionRepository,
  });

  Future<void> login(LoginType loginType) async {
    switch (loginType) {
      case LoginType.kakao:
        return _loginWithKakao();
      case LoginType.apple:
        return _loginWithApple();
    }
  }

  /// 카카오 계정 으로 로그인
  _loginWithKakao() async {
    OAuthToken? token;
    if (await isKakaoTalkInstalled()) {
      try {
        token = await UserApi.instance.loginWithKakaoTalk();
        if (kDebugMode) {
          print('loginWithKakaoTalk succeeds. ${token.accessToken}');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Login fails. $e');
        }
      }
    } else {
      try {
        token = await UserApi.instance.loginWithKakaoAccount();
        if (kDebugMode) {
          print('loginWithKakaoAccount succeeds. ${token.accessToken}');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Login fails. $e');
        }
      }
    }
    if (token == null) {
      throw Exception('Failed to login with kakao');
    }
    final accessToken = token.accessToken;
    final response = await threeDaysApi.loginWithKakao(
      kakaoAccessToken: accessToken,
    );
    if (kDebugMode) {
      print('loginWithKakao response: $response');
    }
    if (response.data == null) {
      if (kDebugMode) {
        print('Failed to get accessToken. response: $response');
      }
    }
    sessionRepository.saveAccessToken(response.data!.token.accessToken);
  }

  /// 애플 계정 으로 로그인
  _loginWithApple() {}
}
