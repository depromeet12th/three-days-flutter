import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/session/session_cubit.dart';
import '../domain/member/member.dart';

class MypageView extends StatefulWidget {
  final Member member;

  MypageView({
    super.key,
    required this.member,
  });

  @override
  State<StatefulWidget> createState() {
    return _MypageViewState();
  }
}

class _MypageViewState extends State<MypageView> {
  final TextEditingController _controller = TextEditingController();
  late String _nickname;
  late bool _switchValue;

  @override
  void initState() {
    super.initState();
    _nickname = widget.member.nickname;
    _switchValue = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(73.0),
          child: AppBar(
            backgroundColor: Color(0xFFF4F6F8),
          ),
        ),
        body: Container(
          color: Color(0xFFF4F6F8),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20,
            ),
            child: Column(
              children: [
                /// 닉네임
                _getNicknameWidget(),
                const SizedBox(
                  height: 32,
                ),

                /// 습관 보관함
                _getArchivedHabitWidget(),
                const SizedBox(
                  height: 8,
                ),

                /// 알림 설정
                _getAlarmSwitchWidget(),
                const SizedBox(
                  height: 8,
                ),

                /// 버전 정보, 서비스 이용 약관, 개인정보처리방침
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      GestureDetector(
                        onTapUp: (_) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Center(
                                child: Text('버전 정보'),
                              ),
                              // TODO: 앱 버전
                              content: const Text('1.0.0'),
                              actions: [
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('확인'),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Text('버전 정보'),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTapUp: (_) {
                          // Navigator.of(context).pushNamed('/mypage/policy/service');
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Text('이용 약관'),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTapUp: (_) {
                          // Navigator.of(context).pushNamed('/mypage/policy/privacy');
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Text('개인정보 처리방침'),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTapUp: (_) {
                          // Navigator.of(context).pushNamed('/mypage/policy/opensource');
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Text('오픈소스 라이선스'),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getLogoutButton(context),
                    const SizedBox(width: 39),
                    const Text('|'),
                    const SizedBox(width: 39),
                    _getWithdrawButton(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getNicknameWidget() {
    return Row(
      children: [
        // TODO: 닉네임 읽어와야함
        Text(_nickname),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('닉네임 수정'),
                content: TextFormField(
                  controller: _controller,
                  maxLength: 10,
                ),
                actions: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('취소'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _nickname = _controller.text;
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text('저장'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          icon: Icon(Icons.edit),
        ),
      ],
    );
  }

  Widget _getArchivedHabitWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
        child: Row(
          children: [
            const Text(
              '습관 보관함',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/habit-archived');
              },
              icon: const Icon(Icons.arrow_forward_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getAlarmSwitchWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          child: Row(
            children: [
              const Text('알림 설정'),
              const Spacer(),
              CupertinoSwitch(
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 로그아웃
  Widget _getLogoutButton(BuildContext context) {
    final sessionCubit = BlocProvider.of<SessionCubit>(context);
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
      ),
      onPressed: () {
        sessionCubit.logout();
      },
      child: const Text('로그아웃'),
    );
  }

  /// 회원탈퇴
  Widget _getWithdrawButton(BuildContext context) {
    final sessionCubit = BlocProvider.of<SessionCubit>(context);
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
      ),
      onPressed: () {
        sessionCubit.signout();
      },
      child: const Text('회원탈퇴'),
    );
  }
}
