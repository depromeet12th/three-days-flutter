import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/session/session_cubit.dart';
import 'auth/session_repository.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionRepository = RepositoryProvider.of<SessionRepository>(context);
    final sessionCubit = BlocProvider.of<SessionCubit>(context);
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
          sessionCubit.logout();
        } else {
          sessionCubit.login();
        }
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
