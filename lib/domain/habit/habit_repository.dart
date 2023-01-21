import 'habit.dart';
import 'habit_add_request_vo.dart';
import 'habit_status.dart';
import 'habit_update_request_vo.dart';

abstract class HabitRepository {
  Future<List<Habit>> findAll();

  Future<List<Habit>> findByStatus({
    required HabitStatus habitStatus,
  });

  Future<Habit?> findById({
    required int habitId,
  });

  Future<Habit> createHabit({
    required HabitAddRequestVo habitAddRequestVo,
  });

  Future<Habit> updateHabit({
    required int habitId,
    required HabitUpdateRequestVo habitUpdateRequestVo,
  });

  Future<void> delete({
    required int habitId,
  });
}
