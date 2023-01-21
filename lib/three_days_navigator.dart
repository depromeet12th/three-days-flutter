import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_days/auth/login_screen.dart';
import 'package:three_days/auth/session/session_cubit.dart';
import 'package:three_days/habit/habit_add_page.dart';
import 'package:three_days/habit/habit_update_page.dart';
import 'package:three_days/home/home_page.dart';
import 'package:three_days/splash_screen.dart';

class ThreeDaysNavigator extends StatelessWidget {
  const ThreeDaysNavigator({super.key});

  static final habitEditPathRegExp = RegExp(r'/habit/(\d+)/edit');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return Navigator(
          pages: _getPages(state),
          onPopPage: (route, result) => route.didPop(result),
          onGenerateRoute: (RouteSettings settings) {
            if (settings.name == null) {
              return MaterialPageRoute(builder: (context) => SplashScreen());
            }
            if (settings.name == '/habit/add') {
              return MaterialPageRoute(builder: (context) => HabitAddPage());
            }
            if (habitEditPathRegExp.hasMatch(settings.name!)) {
              final habitId =
                  int.parse(habitEditPathRegExp.firstMatch(settings.name!)![1]!);
              return MaterialPageRoute(
                builder: (context) => HabitUpdatePage(habitId: habitId),
              );
            }
          },
        );
      },
    );
  }

  List<Page<dynamic>> _getPages(SessionState state) {
    final List<Page<dynamic>> pages = [];
    if (state is UnknownState) {
      pages.add(MaterialPage(child: SplashScreen()));
    }
    if (state is LogoutState) {
      pages.add(MaterialPage(child: LoginScreen()));
    }
    if (state is LoginState) {
      pages.add(MaterialPage(child: HomePage()));
    }
    return pages.toList();
  }
}
