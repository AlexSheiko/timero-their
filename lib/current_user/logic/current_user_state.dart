part of 'current_user_cubit.dart';

abstract class CurrentUserState extends Equatable {
  const CurrentUserState();

  @override
  List<Object?> get props => [];
}

class CurrentUserStateInitial extends CurrentUserState {
  const CurrentUserStateInitial();
}

class CurrentUserLoadInProgress extends CurrentUserState {
  const CurrentUserLoadInProgress();
}

class Authenticated extends CurrentUserState {
  const Authenticated(this.auth);

  final CurrentUser auth;

  @override
  List<Object?> get props => [auth];
}

class Unauthenticated extends CurrentUserState {
  const Unauthenticated();
}

class CurrentUserLoadFailure extends CurrentUserState {
  const CurrentUserLoadFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
