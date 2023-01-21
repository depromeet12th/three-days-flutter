import 'package:three_days/data/habit/habit_assembler.dart';
import 'package:three_days/data/three_days_api.dart';
import 'package:three_days/domain/habit.dart';
import 'package:three_days/domain/habit_add_request_vo.dart';
import 'package:three_days/domain/habit_repository.dart';

import '../../auth/session_repository.dart';
import 'habit_add_request.dart';

class HabitRepositoryImpl implements HabitRepository {
  final ThreeDaysApi threeDaysApi;
  final SessionRepository sessionRepository;
  final habitAssembler = HabitAssembler();

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
  Future<Habit> createHabit({
    required HabitAddRequestVo habitAddRequestVo,
  }) async {
    HabitAddRequest habitAddRequest = habitAssembler.toHabitAddRequest(
      habitAddRequestVo: habitAddRequestVo,
    );
    final apiResponse = await threeDaysApi.createHabit(habitAddRequest);
    return habitAssembler.toHabit(habitResponse: apiResponse.data!);
  }

  Future<Habit> updateHabit(Habit habit) async {
    return habit;
  }
}
