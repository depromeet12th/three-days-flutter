import './../data/habit/habit_response.dart';
import './../data/member_response.dart';

import 'login_response.dart';

class ThreeDaysApiResponse<T> {
  final String code;
  final String message;
  final T? data;

  ThreeDaysApiResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  @override
  String toString() {
    return 'ThreeDaysApiResponse{code: $code, message: $message, data: $data}';
  }

  static ThreeDaysApiResponse<LoginResponse?> loginData(
      Map<String, dynamic> json) {
    return ThreeDaysApiResponse(
      code: json['code'] as String,
      message: json['message'] as String,
      data: LoginResponse.fromJson(json['data']),
    );
  }

  static ThreeDaysApiResponse<MemberResponse?> memberData(
      Map<String, dynamic> json) {
    return ThreeDaysApiResponse(
      code: json['code'] as String,
      message: json['message'] as String,
      data: MemberResponse.fromJson(json['data']),
    );
  }

  static ThreeDaysApiResponse<List<HabitResponse>> habitListData(
      Map<String, dynamic> json) {
    return ThreeDaysApiResponse(
      code: json['code'] as String,
      message: json['message'] as String,
      data:
          (json['data'] as List).map((e) => HabitResponse.fromJson(e)).toList(),
    );
  }

  static ThreeDaysApiResponse<HabitResponse> habitData(
      Map<String, dynamic> json) {
    return ThreeDaysApiResponse(
      code: json['code'] as String,
      message: json['message'] as String,
      data: HabitResponse.fromJson(json['data']),
    );
  }
}
