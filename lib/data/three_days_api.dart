import 'dart:convert';

import 'package:http/http.dart';
import 'package:three_days/auth/login_type.dart';
import 'package:http/http.dart' as http;
import 'package:three_days/auth/session_repository.dart';
import 'package:three_days/data/habit_response.dart';
import 'package:three_days/data/login_response.dart';
import 'package:three_days/data/member_response.dart';
import 'package:three_days/data/three_days_api_exception.dart';

import '../auth/unauthorized_exception.dart';
import 'login_request.dart';
import 'three_days_api_response.dart';

class ThreeDaysApi {
  ThreeDaysApi();

  late SessionRepository _sessionRepository;

  set sessionRepository(SessionRepository value) {
    _sessionRepository = value;
  }

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
        .then((value) => decodeIfSuccess(value))
        .then((value) => ThreeDaysApiResponse.memberData(value));
  }

  /// 습관 목록 조회
  Future<ThreeDaysApiResponse<List<HabitResponse>>> getHabits() async {
    return http
        .get(
          Uri.https(_host, '/api/v1/habits'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${await _getAccessToken()}',
          },
        )
        .then((value) => decodeIfSuccess(value))
        .then((value) => ThreeDaysApiResponse.habitData(value));
  }

  Future<String> _getAccessToken() async {
    final accessToken = await _sessionRepository.getAccessToken();
    if (accessToken == null) {
      throw UnauthorizedException();
    }
    return accessToken;
  }

  dynamic decodeIfSuccess(Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    }
    if (response.statusCode >= 400 && response.statusCode < 500) {
      if (response.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw ThreeDaysApiException('클라이언트 에러. ${json.decode(response.body)}');
    }
    throw ThreeDaysApiException('서버 에러. ${json.decode(response.body)}');
  }
}
