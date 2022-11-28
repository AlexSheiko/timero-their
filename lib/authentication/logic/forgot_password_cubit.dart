import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timero/authentication/data/repository/forgot_password_repository.dart';
import 'package:timero/authentication/logic/auth_state.dart';

class ForgotPasswordCubit extends Cubit<AuthState> {
  ForgotPasswordCubit(
    this.forgotPasswordRepository,
  ) : super(const AuthStateInitial());

  final ForgotPasswordRepository forgotPasswordRepository;

  Future<void> recoverPassword({
    required String email,
  }) async {
    emit(const AuthInProgress());
    final credential = await forgotPasswordRepository.recoverPassword(email);
    if (credential.errorMessage.isEmpty) {
      emit(const ResetPasswordSuccess());
    } else {
      emit(AuthFailure(credential.errorMessage));
    }
  }

  Future<void> onBackPressed() async {
    emit(const AuthStateInitial());
  }
}
