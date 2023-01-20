part of 'session_cubit.dart';

abstract class SessionState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// 로그인 한 상태
class LoginState extends SessionState {}

/// 로그아웃 된 상태
class LogoutState extends SessionState {}

/// 로그인인지 로그아웃인지 모르는 상태
class UnknownState extends SessionState {}
