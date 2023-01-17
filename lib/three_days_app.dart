import 'package:flutter/material.dart';
import 'package:three_days/auth/login_screen.dart';
import 'package:three_days/splash_screen.dart';

import 'home_page.dart';

class ThreeDaysApp extends StatelessWidget {
  const ThreeDaysApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => SplashScreen());
        } else if (settings.name == '/home') {
          return MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter Demo Home Page'));
        } else if (settings.name == '/login') {
          return MaterialPageRoute(builder: (context) => LoginScreen());
        }
      },
    );
  }
}
