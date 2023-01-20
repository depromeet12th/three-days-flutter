import 'package:three_days/domain/day_of_week.dart';

import 'notification_request_vo.dart';

class HabitAddRequestVo {
  final String name;
  final Set<DayOfWeek> dayOfWeeks;
  final NotificationRequestVo? notificationRequestVo;
  final String color;

  HabitAddRequestVo({
    required this.name,
    required this.dayOfWeeks,
    required this.notificationRequestVo,
    required this.color,
  });
}
