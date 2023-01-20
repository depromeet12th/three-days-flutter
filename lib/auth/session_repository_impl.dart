import 'package:shared_preferences/shared_preferences.dart';
import 'package:three_days/data/three_days_api.dart';

import 'session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final ThreeDaysApi threeDaysApi;

  SessionRepositoryImpl({
    required this.threeDaysApi,
  });

  final Future<SharedPreferences> _sharedPreferences =
  SharedPreferences.getInstance();
  static const String threeDaysAccessToken = 'THREE_DAYS_ACCESS_TOKEN';

  @override
  Future<bool> isLoggedIn() async {
    // accessToken 있는지 검사
    final sharedPreferences = await _sharedPreferences;
    final accessToken = sharedPreferences.getString(threeDaysAccessToken);
    if (accessToken == null) {
      return false;
    }
    // api 호출해서 accessToken 이 유효한지 검사
    final myInfoResponse =
    await threeDaysApi.getMyInfo(accessToken: accessToken);
    return myInfoResponse.code == 'success';
  }

  @override
  Future<String?> getAccessToken() async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString(threeDaysAccessToken);
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString(threeDaysAccessToken, accessToken);
  }

  @override
  Future<void> removeAccessToken() async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.remove(threeDaysAccessToken);
  }
}
