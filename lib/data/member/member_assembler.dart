import '../../domain/member/member.dart';
import '../member_response.dart';

class MemberAssembler {
  Member toMember(MemberResponse memberResponse) {
    return Member(
      memberId: memberResponse.id,
      nickname: memberResponse.name,
    );
  }
}
