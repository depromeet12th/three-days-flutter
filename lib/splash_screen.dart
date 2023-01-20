import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_days/auth/login_screen.dart';
import 'package:three_days/home/home_page.dart';

import 'auth/session_repository.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionRepository = RepositoryProvider.of<SessionRepository>(context);
    return FutureBuilder(
      future: sessionRepository.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')));
        }
        final isLoggedIn = snapshot.data ?? false;
        if (!isLoggedIn) {
          return LoginScreen();
        } else {
          return HomePage();
        }
      },
    );
  }
}
