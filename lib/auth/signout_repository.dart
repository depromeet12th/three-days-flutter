import 'package:flutter/foundation.dart';

import '../data/three_days_api.dart';
import 'session_repository.dart';

class SignoutRepository {
  final ThreeDaysApi threeDaysApi;
  final SessionRepository sessionRepository;

  SignoutRepository({
    required this.threeDaysApi,
    required this.sessionRepository,
  });

  Future<void> signout() async {
    final threeDaysApiResponse = await threeDaysApi.withdraw();
    if (kDebugMode) {
      print(threeDaysApiResponse);
    }
  }
}
