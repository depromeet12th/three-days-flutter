import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_days/auth/login_repository.dart';

import 'login_type.dart';
import 'session/session_cubit.dart';

/// 로그인, 회원 가입
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginRepository = RepositoryProvider.of<LoginRepository>(context);
    final sessionCubit = BlocProvider.of<SessionCubit>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    '작심삼일이라면,\n짝심삼일과 함께',
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Image.network(
                    'https://via.placeholder.com/160',
                    height: 160,
                    width: 160,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await loginRepository.login(LoginType.kakao);
                sessionCubit.login();
              },
              child: Text('카카오로 계속하기'),
            ),
          ],
        ),
      ),
    );
  }
}
