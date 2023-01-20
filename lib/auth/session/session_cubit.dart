import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_days/auth/login_repository.dart';
import 'package:three_days/auth/logout_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final LoginRepository loginRepository;
  final LogoutRepository logoutRepository;

  SessionCubit({
    required this.loginRepository,
    required this.logoutRepository,
  }) : super(LogoutState());

  void login() {
    emit(LoginState());
  }

  void logout() {
    emit(LogoutState());
  }
}
