class Member {
  final int memberId;
  final String nickname;

  Member({
    required this.memberId,
    required this.nickname,
  });

  @override
  String toString() {
    return 'Member{memberId: $memberId, nickname: $nickname}';
  }
}
