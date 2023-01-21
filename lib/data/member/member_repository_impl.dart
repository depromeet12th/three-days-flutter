import 'package:three_days/auth/unauthorized_exception.dart';
import 'package:three_days/data/member/member_assembler.dart';
import 'package:three_days/data/three_days_api.dart';
import 'package:three_days/domain/member/member.dart';

import '../../domain/member/member_repository.dart';

class MemberRepositoryImpl implements MemberRepository {
  final ThreeDaysApi _threeDaysApi;
  final memberAssembler = MemberAssembler();

  MemberRepositoryImpl({
    required ThreeDaysApi threeDaysApi,
  }) : _threeDaysApi = threeDaysApi;

  @override
  Future<Member> getMyInfo() async {
    final threeDaysApiResponse = await _threeDaysApi.getMyInfo();
    if (threeDaysApiResponse.code != 'success' ||
        threeDaysApiResponse.data == null) {
      throw UnauthorizedException();
    }
    return memberAssembler.toMember(threeDaysApiResponse.data!);
  }
}
