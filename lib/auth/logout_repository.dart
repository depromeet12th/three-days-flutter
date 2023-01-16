import 'package:three_days/auth/session_repository.dart';

import '../data/three_days_api.dart';

class LogoutRepository {
  final _threeDaysApi = const ThreeDaysApi();
  final _sessionRepository = SessionRepository();

  Future<void> logout() async {
    _sessionRepository.removeAccessToken();
    // TODO: logout api
  }
}
