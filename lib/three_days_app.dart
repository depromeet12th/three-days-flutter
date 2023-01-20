import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_days/auth/login_repository.dart';
import 'package:three_days/auth/login_screen.dart';
import 'package:three_days/auth/logout_repository.dart';
import 'package:three_days/auth/session/session_cubit.dart';
import 'package:three_days/bottom_navigation/cubit/navigation_cubit.dart';
import 'package:three_days/domain/habit_repository.dart';
import 'package:three_days/splash_screen.dart';

import 'auth/session_repository.dart';
import 'auth/session_repository_impl.dart';
import 'data/habit_repository_impl.dart';
import 'data/three_days_api.dart';
import 'home/home_page.dart';
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
    final habitRepository = HabitRepositoryImpl(
      threeDaysApi: threeDaysApi,
      sessionRepository: sessionRepository,
    );
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SessionRepository>(create: (_) => sessionRepository),
        RepositoryProvider(create: (_) => loginRepository),
        RepositoryProvider(create: (_) => logoutRepository),
        RepositoryProvider<HabitRepository>(create: (_) => habitRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SessionCubit(
            loginRepository: loginRepository,
            logoutRepository: logoutRepository,
          )),
        ],
        child: MaterialApp(
          title: '짝심삼일',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ThreeDaysNavigator(),
          // initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            if (settings.name == '/') {
              return MaterialPageRoute(builder: (context) => SplashScreen());
            } else if (settings.name == '/home') {
              return MaterialPageRoute(builder: (context) => HomePage());
            } else if (settings.name == '/login') {
              return MaterialPageRoute(builder: (context) => LoginScreen());
            }
          },
        ),
      ),
    );
  }
}
