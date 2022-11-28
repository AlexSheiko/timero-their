part of 'goals_cubit.dart';

abstract class GoalsState extends Equatable {
  const GoalsState();

  @override
  List<Object?> get props => [];
}

class GoalsStateInitial extends GoalsState {
  const GoalsStateInitial();
}

class GoalsLoadInProgress extends GoalsState {
  const GoalsLoadInProgress();
}

class GoalsLoadSuccess extends GoalsState {
  const GoalsLoadSuccess(this.goals);

  final List<Goal> goals;

  @override
  List<Object?> get props => [goals];
}

class GoalsLoadFailure extends GoalsState {
  const GoalsLoadFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
