import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timero/authentication/data/repository/login_repository.dart';
import 'package:timero/authentication/logic/auth_state.dart';
import 'package:timero/current_user/data/current_user.dart';
import 'package:timero/current_user/data/current_user_repository.dart';

class LoginCubit extends Cubit<AuthState> {
  LoginCubit(
    this._loginRepository,
    this._currentUserRepository,
  ) : super(const AuthStateInitial());

  final LoginRepository _loginRepository;
  final CurrentUserRepository _currentUserRepository;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthInProgress());
    final credential = await _loginRepository.loginWithEmailPassword(
      email,
      password,
    );
    if (credential.userCredential is UserCredential) {
      final currentUser = CurrentUser(
        id: credential.userCredential!.user!.uid,
        name: credential.userCredential!.user!.displayName ?? '',
        email: credential.userCredential!.user!.email!,
      );
      _currentUserRepository.set(currentUser);
      emit(const LoginSuccess());
    } else {
      emit(AuthFailure(credential.errorMessage));
    }
  }

  Future<void> onBackPressed() async {
    emit(const AuthStateInitial());
  }
}
