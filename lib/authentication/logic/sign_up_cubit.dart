import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timero/authentication/data/repository/sign_up_repository.dart';
import 'package:timero/authentication/logic/auth_state.dart';
import 'package:timero/current_user/data/current_user.dart';
import 'package:timero/current_user/data/current_user_repository.dart';

class SignUpCubit extends Cubit<AuthState> {
  SignUpCubit(
    this._signUpRepository,
    this._currentUserRepository,
  ) : super(const AuthStateInitial());

  final SignUpRepository _signUpRepository;
  final CurrentUserRepository _currentUserRepository;

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    emit(const AuthInProgress());
    var credential = await _signUpRepository.signUp(email, password);
    if (credential.userCredential is UserCredential) {
      final currentUser = CurrentUser(
        id: credential.userCredential!.user!.uid,
        name: credential.userCredential!.user!.displayName ?? '',
        email: credential.userCredential!.user!.email!,
      );
      _currentUserRepository.set(currentUser);
      emit(const RegisterSuccess());
    } else {
      emit(AuthFailure(credential.errorMessage));
    }
  }
}
