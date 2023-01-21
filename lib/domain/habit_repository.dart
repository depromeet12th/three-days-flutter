import 'habit.dart';
import 'habit_add_request_vo.dart';

abstract class HabitRepository {
  Future<List<Habit>> findAll();

  Future<Habit> createHabit({
    required HabitAddRequestVo habitAddRequestVo,
  });
}
