import 'package:three_days/util/extensions.dart';

class HabitResponse {
  final int id;
  final String title;
  final String imojiPath;
  final List<String> dayOfWeeks;
  final int reward;
  final String color;
  final String status;
  final DateTime createAt;
  final DateTime? archiveAt;
  final int totalAchievementCount;
  final int? todayHabitAchievementId;
  final int sequence;

  // final MateResponse mate;

  HabitResponse({
    required this.id,
    required this.title,
    required this.imojiPath,
    required this.dayOfWeeks,
    required this.reward,
    required this.color,
    required this.status,
    required this.createAt,
    required this.archiveAt,
    required this.totalAchievementCount,
    required this.todayHabitAchievementId,
    required this.sequence,
  });

  static HabitResponse fromJson(Map<String, dynamic> json) {
    return HabitResponse(
      id: json['id'] as int,
      title: json['title'] as String,
      imojiPath: json['imojiPath'] as String,
      dayOfWeeks: (json['dayOfWeeks'] as List).map((e) => e as String).toList(),
      reward: json['reward'] as int,
      color: json['color'] as String,
      status: json['status'] as String,
      createAt: DateTime.parse(json['createAt'] as String),
      archiveAt: (json['archiveAt'] as String?)?.let((e) => DateTime.parse(e)),
      totalAchievementCount: json['totalAchievementCount'] as int,
      todayHabitAchievementId: json['todayHabitAchievementId'] as int?,
      sequence: json['sequence'] as int,
    );
  }

  @override
  String toString() {
    return 'HabitResponse{id: $id, title: $title, imojiPath: $imojiPath, dayOfWeeks: $dayOfWeeks, reward: $reward, color: $color, status: $status, createAt: $createAt, archiveAt: $archiveAt, totalAchievementCount: $totalAchievementCount, todayHabitAchievementId: $todayHabitAchievementId, sequence: $sequence}';
  }
}
