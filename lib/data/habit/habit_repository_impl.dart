import 'package:flutter/foundation.dart';
import 'package:three_days/util/extensions.dart';

import '../../domain/habit/habit.dart';
import '../../domain/habit/habit_add_request_vo.dart';
import '../../domain/habit/habit_repository.dart';
import '../../domain/habit/habit_status.dart';
import '../../domain/habit/habit_update_request_vo.dart';
import '../three_days_api.dart';
import 'habit_add_request.dart';
import 'habit_assembler.dart';
import 'habit_update_request.dart';

class HabitRepositoryImpl implements HabitRepository {
  final ThreeDaysApi threeDaysApi;
  final habitAssembler = HabitAssembler();

  HabitRepositoryImpl({
    required this.threeDaysApi,
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
  Future<List<Habit>> findByStatus({
    required HabitStatus habitStatus,
  }) async {
    final apiResponse = await threeDaysApi.getHabits(
      habitStatus: HabitStatus.active,
    );
    return apiResponse.data!
        .map((e) => Habit(
              habitId: e.id,
              title: e.title,
            ))
        .toList();
  }

  @override
  Future<Habit?> findById({
    required int habitId,
  }) async {
    final apiResponse = await threeDaysApi.getHabit(
      habitId: habitId,
    );
    return apiResponse.data?.let((e) => Habit(
          habitId: e.id,
          title: e.title,
        ));
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

  @override
  Future<Habit> updateHabit({
    required int habitId,
    required HabitUpdateRequestVo habitUpdateRequestVo,
  }) async {
    HabitUpdateRequest habitUpdateRequest = habitAssembler.toHabitUpdateRequest(
      habitUpdateRequestVo: habitUpdateRequestVo,
    );
    final apiResponse = await threeDaysApi.updateHabit(
      habitId: habitId,
      habitUpdateRequest: habitUpdateRequest,
    );
    return habitAssembler.toHabit(habitResponse: apiResponse.data!);
  }

  @override
  Future<void> delete({
    required int habitId,
  }) async {
    final apiResponse = await threeDaysApi.delete(habitId: habitId);
    if (kDebugMode) {
      print(apiResponse);
    }
  }
}
