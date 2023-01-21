import 'package:equatable/equatable.dart';

abstract class HabitAddState implements Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

/// 제출 불가능
class HabitAddCannotSubmitState extends HabitAddState {}

/// 제출 가능
class HabitAddReadyState extends HabitAddState {}

/// 처리중
class HabitAddProcessingState extends HabitAddState {}

/// 성공
class HabitAddSuccessState extends HabitAddState {
  final int habitId;

  HabitAddSuccessState({required this.habitId});

  @override
  List<Object?> get props => [habitId];

  @override
  bool? get stringify => true;
}

/// 실패
class HabitAddFailureState extends HabitAddState {
}
