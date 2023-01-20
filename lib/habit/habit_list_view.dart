import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_days/auth/unauthorized_exception.dart';
import 'package:three_days/domain/habit_repository.dart';

import '../domain/habit.dart';

class HabitListView extends StatelessWidget {
  const HabitListView({super.key});

  @override
  Widget build(BuildContext context) {
    final habitRepository = RepositoryProvider.of<HabitRepository>(context);
    return FutureBuilder<List<Habit>>(
      future: habitRepository.findAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return _getLoading();
        }
        if (snapshot.hasError) {
          if (snapshot.error is UnauthorizedException) {
            print(snapshot.error.toString());
            return _getLoading();
          }
          return Center(child: Text(snapshot.error.toString()));
        }
        final habits = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              _getHeader(),
              SizedBox(
                height: 4,
              ),
              _getBody(context, habits),
            ],
          ),
        );
      },
    );
  }

  Widget _getLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _getHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        children: [
          Text('1월 2일 월요일'),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }

  Widget _getBody(BuildContext context, List<Habit> habits) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: habits.map((e) => _getHabitCard(context, e)).toList(),
            ),
            _getAddHabitCard(context),
          ],
        ),
      ),
    );
  }

  Widget _getHabitCard(BuildContext context, Habit habit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 140,
        child: Center(
          child: Text(habit.title),
        ),
      ),
    );
  }

  Widget _getAddHabitCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTapUp: (_) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('습관 만들기'),
          ));
        },
        child: SizedBox(
          height: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              Text('습관 만들기'),
            ],
          ),
        ),
      ),
    );
  }
}
