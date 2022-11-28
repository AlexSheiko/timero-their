part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInProgress extends SettingsState {
  const SettingsInProgress();
}

class SettingsStateInitial extends SettingsState {
  const SettingsStateInitial();
}

class LogOutState extends SettingsState {
  const LogOutState();
}

class EmailReadyState extends SettingsState {
  const EmailReadyState(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

class SettingsFailure extends SettingsState {
  const SettingsFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
