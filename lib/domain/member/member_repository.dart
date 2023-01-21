import 'member.dart';

abstract class MemberRepository {
  Future<Member> getMyInfo();
}
