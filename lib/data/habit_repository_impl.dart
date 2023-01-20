import 'package:three_days/data/three_days_api.dart';
import 'package:three_days/domain/habit.dart';
import 'package:three_days/domain/habit_repository.dart';

import '../auth/session_repository.dart';
import 'three_days_api_exception.dart';

class HabitRepositoryImpl implements HabitRepository {
  final ThreeDaysApi threeDaysApi;
  final SessionRepository sessionRepository;

  HabitRepositoryImpl({
    required this.threeDaysApi,
    required this.sessionRepository,
  });

  @override
  Future<List<Habit>> findAll() async {
    final apiResponse = await threeDaysApi.getHabits();
    return apiResponse.data!
        .map((e) => Habit(
              habitId: e.id,
              title: e.title,
            ))
        .toList();
  }

  @override
  Future<Habit> save(Habit habit) async {
    return habit;
  }
}
