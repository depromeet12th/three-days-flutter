import 'package:three_days/auth/session_repository.dart';

import '../data/three_days_api.dart';

class LogoutRepository {
  final ThreeDaysApi threeDaysApi;
  final SessionRepository sessionRepository;

  LogoutRepository({
    required this.threeDaysApi,
    required this.sessionRepository,
  });

  Future<void> logout() async {
    sessionRepository.removeAccessToken();
    // TODO: logout api
  }
}
