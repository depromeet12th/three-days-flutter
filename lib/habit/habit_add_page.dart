import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/habit/habit_add_cubit.dart';
import '../domain/habit_repository.dart';
import 'habit_add_view.dart';

class HabitAddPage extends StatelessWidget {
  const HabitAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HabitAddCubit>(
      create: (_) =>
          HabitAddCubit(
            habitRepository: RepositoryProvider.of<HabitRepository>(context),
          ),
      child: HabitAddView(),
    );
  }
}
