import 'package:intl/intl.dart';

class NotificationRequest {
  final DateTime notificationTime;
  final String contents;

  NotificationRequest({
    required this.notificationTime,
    required this.contents,
  });

  Map<String, dynamic> toMap() {
    return {
      'notificationTime': DateFormat.Hms().format(notificationTime),
      'contents': contents,
    };
  }

  @override
  String toString() {
    return 'NotificationRequest{notificationTime: $notificationTime, contents: $contents}';
  }
}
