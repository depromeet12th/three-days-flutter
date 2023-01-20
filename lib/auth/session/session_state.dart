part of 'session_cubit.dart';

abstract class SessionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginState extends SessionState {}

class LogoutState extends SessionState {}
