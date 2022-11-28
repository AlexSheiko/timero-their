import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timero/authentication/data/repository/change_password_repository.dart';
import 'package:timero/authentication/logic/auth_state.dart';
import 'package:timero/current_user/data/current_user.dart';
import 'package:timero/current_user/data/current_user_repository.dart';

class ChangePasswordCubit extends Cubit<AuthState> {
  ChangePasswordCubit(this.changePasswordRepository, this.currentUserRepository)
      : super(const AuthStateInitial());
  final ChangePasswordRepository changePasswordRepository;
  final CurrentUserRepository currentUserRepository;

  Future<void> changePassword({
    required String password,
  }) async {
    emit(const AuthInProgress());
    final credential = await changePasswordRepository.changePassword(password);
    var user = changePasswordRepository.getCurrentUser();
    currentUserRepository.set(CurrentUser(
        id: user!.uid,
        email: user.email.toString(),
        name: user.displayName ?? ''));
    if (credential.errorMessage.isEmpty) {
      emit(const ChangePasswordSuccess());
    } else {
      emit(AuthFailure(credential.errorMessage));
    }
  }
}
