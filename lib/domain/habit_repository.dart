import 'habit.dart';
import 'habit_add_request_vo.dart';
import 'habit_status.dart';

abstract class HabitRepository {
  Future<List<Habit>> findAll();

  Future<List<Habit>> findByStatus({
    required HabitStatus habitStatus,
  });

  Future<Habit> createHabit({
    required HabitAddRequestVo habitAddRequestVo,
  });

  Future<void> delete({
    required int habitId,
  });
}
