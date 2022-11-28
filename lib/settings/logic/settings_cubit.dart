import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timero/authentication/data/credential.dart';
import 'package:timero/current_user/data/current_user_repository.dart';
import 'package:timero/settings/data/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.settingsRepository, this.currentUserRepository)
      : super(const SettingsStateInitial());
  final CurrentUserRepository currentUserRepository;
  final SettingsRepository settingsRepository;
  String email = '';

  void getEmail() {
    email = settingsRepository.getEmail();
    emit(EmailReadyState(email));
  }

  Future<void> logOut() async {
    emit(const SettingsInProgress());
    currentUserRepository.logOut();
    Credential credential = await settingsRepository.logOut();

    if (credential.errorMessage.isEmpty) {
      emit(const LogOutState());
    } else {
      emit(SettingsFailure(credential.errorMessage));
    }
  }
}
