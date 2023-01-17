import 'dart:convert';

import 'package:three_days/auth/login_type.dart';
import 'package:http/http.dart' as http;
import 'package:three_days/data/login_response.dart';
import 'package:three_days/data/member_response.dart';

import 'login_request.dart';
import 'three_days_api_response.dart';

class ThreeDaysApi {
  const ThreeDaysApi();

  // FIXME:
  //  - debug/release 분리
  //  - dotenv 주입
  final String _host = "api.jjaksim.com";

  /// 카카오 계정으로 로그인
  Future<ThreeDaysApiResponse<LoginResponse?>> loginWithKakao({
    required String kakaoAccessToken,
  }) async {
    final loginRequest = LoginRequest(
      loginType: LoginType.kakao,
      socialToken: kakaoAccessToken,
    );
    return http
        .post(
          Uri.https(_host, '/api/v1/members'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: json.encode(loginRequest.toMap()),
        )
        .then((value) => json.decode(value.body))
        .then((value) => ThreeDaysApiResponse.loginData(value));
  }

  /// 내 정보 조회
  Future<ThreeDaysApiResponse<MemberResponse?>> getMyInfo({
    required String accessToken,
  }) async {
    return http
        .get(
          Uri.https(_host, '/api/v1/members/me'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
          },
        )
        .then((value) => json.decode(value.body))
        .then((value) => ThreeDaysApiResponse.memberData(value));
  }
}
