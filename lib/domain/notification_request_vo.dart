class NotificationRequestVo {
  /// HH:mm:ss
  final DateTime notificationTime;
  final String notificationContent;

  NotificationRequestVo({
    required this.notificationTime,
    required this.notificationContent,
  });

  @override
  String toString() {
    return 'NotificationRequestVo{notificationTime: $notificationTime, notificationContent: $notificationContent}';
  }
}
