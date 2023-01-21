import 'package:three_days/domain/notification_request_vo.dart';

import 'notification_add_request.dart';

class NotificationAssembler {
  NotificationRequest toNotificationRequest({
    required NotificationRequestVo notificationRequestVo,
  }) {
    return NotificationRequest(
      notificationTime: notificationRequestVo.notificationTime,
      contents: notificationRequestVo.notificationContent,
    );
  }
}
