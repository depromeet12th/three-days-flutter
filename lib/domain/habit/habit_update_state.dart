import 'package:equatable/equatable.dart';

abstract class HabitUpdateState implements Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class HabitUpdateLoadingState extends HabitUpdateState {}

class HabitUpdateCannotSubmitState extends HabitUpdateState {}

class HabitUpdateReadyState extends HabitUpdateState {}

class HabitUpdateSuccessState extends HabitUpdateState {
  final int habitId;

  HabitUpdateSuccessState({
    required this.habitId,
  });

  @override
  List<Object> get props => [habitId];

  @override
  bool get stringify => true;
}

class HabitUpdateFailureState extends HabitUpdateState {}
