import 'package:flutter_bloc/flutter_bloc.dart';

import 'habit_repository.dart';
import 'habit_update_request_vo.dart';
import 'habit_update_state.dart';

class HabitUpdateCubit extends Cubit<HabitUpdateState> {
  final HabitRepository habitRepository;

  HabitUpdateCubit({
    required this.habitRepository,
  }) : super(HabitUpdateLoadingState());

  void validate({
    required HabitUpdateRequestVo habitUpdateRequestVo,
  }) {
    if (habitUpdateRequestVo.isValid()) {
      emit(HabitUpdateReadyState());
    } else {
      emit(HabitUpdateCannotSubmitState());
    }
  }

  Future<void> submit({
    required int habitId,
    required HabitUpdateRequestVo habitUpdateRequestVo,
  }) async {
    return habitRepository
        .updateHabit(
          habitId: habitId,
          habitUpdateRequestVo: habitUpdateRequestVo,
        )
        .then((value) => emit(HabitUpdateSuccessState(habitId: value.habitId)))
        .onError((error, stackTrace) => emit(HabitUpdateFailureState()));
  }
}
