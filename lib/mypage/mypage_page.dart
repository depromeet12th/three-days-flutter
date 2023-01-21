import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_days/domain/member/member_repository.dart';

import '../domain/member/member.dart';
import 'mypage_view.dart';

class MyPagePage extends StatelessWidget {
  MyPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final memberRepository = RepositoryProvider.of<MemberRepository>(context);
    return FutureBuilder<Member>(
      future: memberRepository.getMyInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Center(
            child: Text('회원 정보를 조회하는데 실패했습니다.'),
          );
        }
        return MypageView(
          member: snapshot.data!,
        );
      }
    );
  }
}
