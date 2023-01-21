import '../../domain/habit/habit_update_request_vo.dart';
import './../../util/extensions.dart';
import '../../domain/habit/habit.dart';
import '../../domain/habit/habit_add_request_vo.dart';
import 'habit_add_request.dart';
import 'habit_response.dart';
import 'habit_update_request.dart';
import 'notification_assembler.dart';

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

  HabitUpdateRequest toHabitUpdateRequest({
    required HabitUpdateRequestVo habitUpdateRequestVo,
  }) {
    return HabitUpdateRequest(
      title: habitUpdateRequestVo.title,
      imojiPath: habitUpdateRequestVo.emoji,
      color: habitUpdateRequestVo.color.name.toUpperCase(),
      dayOfWeeks: habitUpdateRequestVo.dayOfWeeks.toList(),
      notification: habitUpdateRequestVo.notificationRequestVo?.let(
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
