class Habit {
  final int habitId;
  final String title;

  Habit({
    this.habitId = 0,
    required this.title,
  });

  /// index: 0,1,2 위젯 중에 몇번째 인덱스 위젯인지
  bool isChecked(int currentIndex, int focusedIndex, bool isCheckedAtToday) {
    if (focusedIndex > currentIndex) {
      return true;
    }
    if (focusedIndex == currentIndex) {
      return isCheckedAtToday;
    }
    // focusedIndex < currentIndex 는 아직 도래하지않은 짝! 이므로 무조건 false
    return false;
  }
}
