import 'habit.dart';

abstract class HabitRepository {
  Future<List<Habit>> findAll();

  Future<Habit> save(Habit habit);
}
