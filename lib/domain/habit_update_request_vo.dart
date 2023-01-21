import 'day_of_week.dart';
import 'habit_color.dart';
import 'notification_request_vo.dart';

class HabitUpdateRequestVo {
  final String emoji;
  final String title;
  final Set<DayOfWeek> dayOfWeeks;
  final NotificationRequestVo? notificationRequestVo;
  final HabitColor color;

  HabitUpdateRequestVo({
    required this.emoji,
    required this.title,
    required this.dayOfWeeks,
    required this.notificationRequestVo,
    required this.color,
  });

  bool isValid() {
    if (title.isEmpty) {
      return false;
    }
    if (title.length > 15) {
      return false;
    }
    if (dayOfWeeks.length < 3) {
      return false;
    }
    return true;
  }

  HabitUpdateRequestVo copyOf({
    String? emoji,
    String? title,
    Set<DayOfWeek>? dayOfWeeks,
    NotificationRequestVo? notificationRequestVo,
    HabitColor? color,
  }) {
    return HabitUpdateRequestVo(
      emoji: emoji ?? this.emoji,
      title: title ?? this.title,
      dayOfWeeks: dayOfWeeks ?? this.dayOfWeeks,
      notificationRequestVo: notificationRequestVo ?? this.notificationRequestVo,
      color: color ?? this.color,
    );
  }
}
