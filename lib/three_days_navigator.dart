import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_days/auth/login_screen.dart';
import 'package:three_days/auth/session/session_cubit.dart';
import 'package:three_days/home/home_page.dart';
import 'package:three_days/home/home_view.dart';

class ThreeDaysNavigator extends StatelessWidget {
  const ThreeDaysNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return Navigator(
          pages: _getPages(state),
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }

  List<Page<dynamic>> _getPages(SessionState state) {
    final List<Page<dynamic>> pages = [];
    if (state is LogoutState) {
      pages.add(MaterialPage(child: LoginScreen()));
    }
    if (state is LoginState) {
      pages.add(MaterialPage(child: HomePage()));
    }
    return pages.toList();
  }
}
