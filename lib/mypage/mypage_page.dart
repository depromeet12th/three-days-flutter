import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_days/auth/logout_repository.dart';
import 'package:three_days/auth/session/session_cubit.dart';

class MyPagePage extends StatelessWidget {
  MyPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logoutRepository = RepositoryProvider.of<LogoutRepository>(context);
    final sessionCubit = BlocProvider.of<SessionCubit>(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await logoutRepository.logout();
              sessionCubit.logout();
            },
            child: Text('로그아웃'),
          ),
        ),
      ),
    );
  }
}
