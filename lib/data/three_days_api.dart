import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../auth/login_type.dart';
import '../auth/session_repository.dart';
import '../auth/unauthorized_exception.dart';
import '../domain/habit/habit_status.dart';
import 'habit/habit_add_request.dart';
import 'habit/habit_response.dart';
import 'habit/habit_update_request.dart';
import 'login_request.dart';
import 'login_response.dart';
import 'member_response.dart';
import 'three_days_api_exception.dart';
import 'three_days_api_response.dart';

class ThreeDaysApi {
  ThreeDaysApi();

  late SessionRepository _sessionRepository;

  set sessionRepository(SessionRepository sessionRepository) {
    _sessionRepository = sessionRepository;
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
        .then((value) => json.decode(utf8.decode(value.bodyBytes)))
        .then((value) => ThreeDaysApiResponse.loginData(value));
  }

  /// 내 정보 조회
  Future<ThreeDaysApiResponse<MemberResponse?>> getMyInfo() async {
    return http
        .get(
          Uri.https(_host, '/api/v1/members/me'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${await _getAccessToken()}',
          },
        )
        .then((value) => decodeIfSuccess(value))
        .then((value) => ThreeDaysApiResponse.memberData(value));
  }

  /// 회원 탈퇴
  Future<ThreeDaysApiResponse> withdraw() async {
    return http
        .delete(
          Uri.https(_host, '/api/v1/members'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${await _getAccessToken()}',
          },
        )
        .then((value) => decodeIfSuccess(value))
        .then((value) => ThreeDaysApiResponse.emptyData(value));
  }

  /// 습관 목록 조회
  Future<ThreeDaysApiResponse<List<HabitResponse>>> getHabits({
    HabitStatus? habitStatus,
  }) async {
    Map<String, dynamic> queryParameters = {};
    if (habitStatus != null) {
      queryParameters['status'] = habitStatus.name.toUpperCase();
    }
    return http
        .get(
          Uri.https(_host, '/api/v1/habits', queryParameters),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${await _getAccessToken()}',
          },
        )
        .then((value) => decodeIfSuccess(value))
        .then((value) => ThreeDaysApiResponse.habitListData(value));
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
      return json.decode(utf8.decode(response.bodyBytes));
    }
    if (response.statusCode >= 400 && response.statusCode < 500) {
      if (response.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw ThreeDaysApiException(
          '클라이언트 에러. ${utf8.decode(response.bodyBytes)}');
    }
    throw ThreeDaysApiException('서버 에러. ${utf8.decode(response.bodyBytes)}');
  }

  /// 습관 1개 조회
  Future<ThreeDaysApiResponse<HabitResponse>> getHabit({
    required int habitId,
  }) async {
    return http
        .get(
          Uri.https(_host, '/api/v1/habits/$habitId'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${await _getAccessToken()}',
          },
        )
        .then((value) => decodeIfSuccess(value))
        .then((value) => ThreeDaysApiResponse.habitData(value));
  }

  /// 습관 생성
  Future<ThreeDaysApiResponse<HabitResponse>> createHabit(
    HabitAddRequest habitAddRequest,
  ) async {
    return http
        .post(
          Uri.https(_host, '/api/v1/habits'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${await _getAccessToken()}',
          },
          body: json.encode(habitAddRequest.toMap()),
        )
        .then((value) => decodeIfSuccess(value))
        .then((value) => ThreeDaysApiResponse.habitData(value));
  }

  /// 습관 수정
  Future<ThreeDaysApiResponse<HabitResponse>> updateHabit({
    required int habitId,
    required HabitUpdateRequest habitUpdateRequest,
  }) async {
    return http
        .put(
          Uri.https(_host, '/api/v1/habits/$habitId}'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${await _getAccessToken()}',
          },
          body: json.encode(habitUpdateRequest.toMap()),
        )
        .then((value) => decodeIfSuccess(value))
        .then((value) => ThreeDaysApiResponse.habitData(value));
  }

  /// 습관 삭제
  Future<ThreeDaysApiResponse> delete({required int habitId}) async {
    return http
        .delete(
          Uri.https(_host, '/api/v1/habits/$habitId'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${await _getAccessToken()}',
          },
        )
        .then((value) => decodeIfSuccess(value))
        .then((value) => ThreeDaysApiResponse.emptyData(value));
  }
}
