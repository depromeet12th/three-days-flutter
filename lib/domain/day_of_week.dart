enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
  ;

  String getDisplayName() {
    switch (this) {
      case DayOfWeek.monday:
        return '월';
      case DayOfWeek.tuesday:
        return '화';
      case DayOfWeek.wednesday:
        return '수';
      case DayOfWeek.thursday:
        return '목';
      case DayOfWeek.friday:
        return '금';
      case DayOfWeek.saturday:
        return '토';
      case DayOfWeek.sunday:
        return '일';
    }
  }
}
