import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'habit_add_request_vo.dart';
import 'habit_add_state.dart';
import 'habit_repository.dart';

class HabitAddCubit extends Cubit<HabitAddState> {
  final HabitRepository habitRepository;

  HabitAddCubit({
    required this.habitRepository,
  }) : super(HabitAddCannotSubmitState());

  void validate(HabitAddRequestVo habitAddRequestVo) {
    if (kDebugMode) {
      print('validate: $habitAddRequestVo');
    }
    if (habitAddRequestVo.isValid()) {
      emit(HabitAddReadyState());
    } else {
      emit(HabitAddCannotSubmitState());
    }
  }

  Future<void> submit(HabitAddRequestVo habitAddRequestVo) async {
    if (kDebugMode) {
      print('submit: $habitAddRequestVo');
    }
    emit(HabitAddProcessingState());
    return await habitRepository
        .createHabit(habitAddRequestVo: habitAddRequestVo)
        .then((value) => emit(HabitAddSuccessState(habitId: value.habitId)))
        .onError((error, stackTrace) => emit(HabitAddFailureState()));
  }
}
