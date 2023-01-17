import 'package:flutter/material.dart';
import 'package:three_days/auth/logout_repository.dart';

class MyPagePage extends StatelessWidget {
  MyPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await LogoutRepository().logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (_) => false,
              );
            },
            child: Text('로그아웃'),
          ),
        ),
      ),
    );
  }
}
