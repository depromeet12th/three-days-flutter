import '../../domain/day_of_week.dart';
import 'notification_add_request.dart';

class HabitUpdateRequest {
  final String title;
  final String imojiPath;
  final String color;
  final List<DayOfWeek> dayOfWeeks;
  final NotificationRequest? notification;

  HabitUpdateRequest({
    required this.title,
    required this.imojiPath,
    required this.color,
    required this.dayOfWeeks,
    required this.notification,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imojiPath': imojiPath,
      'color': color,
      'dayOfWeeks': dayOfWeeks.map((e) => e.name.toUpperCase()).toList(),
      'notification': notification?.toMap(),
    };
  }
}
