import 'package:flutter/material.dart';

class MyPagePage extends StatelessWidget {
  const MyPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('MyPagePage'),
        ),
      ),
    );
  }
}
