import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login_repository.dart';
import '../logout_repository.dart';
import '../signout_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final LoginRepository _loginRepository;
  final LogoutRepository _logoutRepository;
  final SignoutRepository _signoutRepository;

  SessionCubit({
    required LoginRepository loginRepository,
    required LogoutRepository logoutRepository,
    required SignoutRepository signoutRepository,
  })  : _signoutRepository = signoutRepository,
        _logoutRepository = logoutRepository,
        _loginRepository = loginRepository,
        super(UnknownState());

  /// 로그인
  void login() {
    emit(LoginState());
  }

  /// 로그아웃
  Future<void> logout() async {
    return _logoutRepository
        .logout()
        .then((value) => emit(LogoutState()))
        .onError((error, stackTrace) => emit(UnknownState()));
  }

  /// 회원탈퇴
  Future<void> signout() async {
    return _signoutRepository
        .signout()
        .then((value) => emit(LogoutState()))
        .onError((error, stackTrace) => emit(UnknownState()));
  }
}
