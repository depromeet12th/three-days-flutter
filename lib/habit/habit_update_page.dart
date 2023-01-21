import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/habit/habit.dart';
import '../domain/habit/habit_repository.dart';
import '../domain/habit/habit_update_cubit.dart';
import 'habit_update_view.dart';

class HabitUpdatePage extends StatelessWidget {
  final int habitId;

  const HabitUpdatePage({
    super.key,
    required this.habitId,
  });

  @override
  Widget build(BuildContext context) {
    final habitRepository = RepositoryProvider.of<HabitRepository>(context);
    return BlocProvider<HabitUpdateCubit>(
      create: (_) => HabitUpdateCubit(
        habitRepository: habitRepository,
      ),
      child: FutureBuilder<Habit?>(
          future: habitRepository.findById(habitId: habitId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(
                child: Text('습관 데이터를 조회하는데 실패했습니다.'),
              );
            }
            return HabitUpdateView(
              habit: snapshot.data!,
            );
          }),
    );
  }
}
