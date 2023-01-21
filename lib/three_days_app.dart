import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/login_repository.dart';
import 'auth/logout_repository.dart';
import 'auth/session/session_cubit.dart';
import 'auth/session_repository.dart';
import 'auth/session_repository_impl.dart';
import 'auth/signout_repository.dart';
import 'data/habit/habit_repository_impl.dart';
import 'data/member/member_repository_impl.dart';
import 'data/three_days_api.dart';
import 'design/three_days_colors.dart';
import 'domain/habit/habit_repository.dart';
import 'domain/member/member_repository.dart';
import 'three_days_navigator.dart';

class ThreeDaysApp extends StatelessWidget {
  const ThreeDaysApp({super.key});

  @override
  Widget build(BuildContext context) {
    final threeDaysApi = ThreeDaysApi();
    final sessionRepository = SessionRepositoryImpl(threeDaysApi: threeDaysApi);
    threeDaysApi.sessionRepository = sessionRepository;
    final loginRepository = LoginRepository(
      threeDaysApi: threeDaysApi,
      sessionRepository: sessionRepository,
    );
    final logoutRepository = LogoutRepository(
      threeDaysApi: threeDaysApi,
      sessionRepository: sessionRepository,
    );
    final signoutRepository = SignoutRepository(
      threeDaysApi: threeDaysApi,
      sessionRepository: sessionRepository,
    );
    final memberRepository = MemberRepositoryImpl(
      threeDaysApi: threeDaysApi,
    );
    final habitRepository = HabitRepositoryImpl(
      threeDaysApi: threeDaysApi,
    );
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SessionRepository>(create: (_) => sessionRepository),
        RepositoryProvider<LoginRepository>(create: (_) => loginRepository),
        RepositoryProvider<LogoutRepository>(create: (_) => logoutRepository),
        RepositoryProvider<SignoutRepository>(create: (_) => signoutRepository),
        RepositoryProvider<MemberRepository>(create: (_) => memberRepository),
        RepositoryProvider<HabitRepository>(create: (_) => habitRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SessionCubit(
              loginRepository: loginRepository,
              logoutRepository: logoutRepository,
              signoutRepository: signoutRepository,
            ),
          ),
        ],
        child: MaterialApp(
          title: '짝심삼일',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
              elevation: 0.0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              titleTextStyle: TextStyle(
                color: ThreeDaysColors.grey800,
              ),
            ),
          ),
          home: ThreeDaysNavigator(),
        ),
      ),
    );
  }
}
