import 'package:flutter/material.dart';
import 'package:three_days/auth/login_repository.dart';

import 'login_type.dart';

/// 로그인, 회원 가입
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _loginRepository = LoginRepository();

  @override
  Widget build(BuildContext context) {
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
                await _loginRepository.login(LoginType.kakao);
                Navigator.of(context).pushReplacementNamed('/home');
              },
              child: Text('카카오로 계속하기'),
            ),
          ],
        ),
      ),
    );
  }
}
