import 'package:flutter/material.dart';
import 'package:three_days/auth/login_screen.dart';
import 'package:three_days/home/home_page.dart';

import 'auth/session_repository.dart';

class SplashScreen extends StatelessWidget {
  final _sessionRepository = SessionRepository();

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _sessionRepository.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: const Text('Loading')));
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
