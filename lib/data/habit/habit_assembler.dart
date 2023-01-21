import 'package:three_days/data/habit/habit_response.dart';
import 'package:three_days/data/habit/notification_assembler.dart';
import 'package:three_days/domain/habit_add_request_vo.dart';
import 'package:three_days/util/extensions.dart';

import '../../domain/habit.dart';
import 'habit_add_request.dart';

class HabitAssembler {
  final notificationAssembler = NotificationAssembler();

  HabitAddRequest toHabitAddRequest({
    required HabitAddRequestVo habitAddRequestVo,
  }) {
    return HabitAddRequest(
      title: habitAddRequestVo.title,
      imojiPath: habitAddRequestVo.emoji,
      color: habitAddRequestVo.color.name.toUpperCase(),
      dayOfWeeks: habitAddRequestVo.dayOfWeeks.toList(),
      notification: habitAddRequestVo.notificationRequestVo?.let(
        (notificationRequestVo) => notificationAssembler.toNotificationRequest(
          notificationRequestVo: notificationRequestVo,
        ),
      ),
    );
  }

  Habit toHabit({
    required HabitResponse habitResponse,
  }) {
    return Habit(
      habitId: habitResponse.id,
      title: habitResponse.title,
    );
  }
}
