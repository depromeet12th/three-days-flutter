import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_days/domain/habit_add_request_vo.dart';

import '../habit_repository.dart';
import 'habit_add_state.dart';

class HabitAddCubit extends Cubit<HabitAddState> {
  final HabitRepository habitRepository;

  HabitAddCubit({
    required this.habitRepository,
  }) : super(HabitAddCannotSubmitState());

  void validate(HabitAddRequestVo habitAddRequestVo) {
    print('validate: $habitAddRequestVo');
    if (habitAddRequestVo.isValid()) {
      emit(HabitAddReadyState());
    } else {
      emit(HabitAddCannotSubmitState());
    }
  }

  Future<void> submit(HabitAddRequestVo habitAddRequestVo) async {
    print('submit: $habitAddRequestVo');
    emit(HabitAddProcessingState());
    return await habitRepository
        .createHabit(habitAddRequestVo: habitAddRequestVo)
        .then((value) => emit(HabitAddSuccessState(habitId: value.habitId)))
        .onError((error, stackTrace) => emit(HabitAddFailureState()));
  }
}
