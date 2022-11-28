import 'package:equatable/equatable.dart';
import 'package:error_handling/error_handling.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timero/home/data/goals_repository.dart';
import 'package:timero/home/data/model/goal.dart';

import '../../current_user/data/current_user_repository.dart';

part 'goals_state.dart';

class GoalsCubit extends Cubit<GoalsState> {
  GoalsCubit(this._goalsRepository, this._currentUserRepository)
      : super(const GoalsStateInitial());

  final GoalsRepository _goalsRepository;
  final CurrentUserRepository _currentUserRepository;
  bool isPremiumActive = false;

  Future<void> onPageOpened() async {
    await _refreshGoals();
  }

  Future<void> addName(String name, String id) async {
    await _goalsRepository.addName(name, id);
    _refreshGoals();
  }

  Future<void> addDays(String days, String id) async {
    await _goalsRepository.addDays(days, id);
    _refreshGoals();
  }

  Future<void> addReset(Goal goal) async {
    try {
      await _goalsRepository.addReset(goal);
    } on UserCanceledException {
      emit(const GoalsStateInitial());
    } catch (e) {
      emit(GoalsLoadFailure(parseErrorMessageFrom(e)));
    }
    try {
      final goals = await _goalsRepository.getGoals();
      emit(GoalsLoadSuccess(goals));
    } on UserCanceledException {
      emit(const GoalsStateInitial());
    } catch (e) {
      emit(GoalsLoadFailure(parseErrorMessageFrom(e)));
    }
  }

  Future<void> deleteGoals(Goal goal) async {
    await _goalsRepository.deleteGoal(goal);
    _refreshGoals();
  }

  Future<void> deleteDays(String id) async {
    await _goalsRepository.deleteDays(id);
    _refreshGoals();
  }

  Future<void> addGoal({required String name}) async {
    final currentUser = _currentUserRepository.currentUser;
    final goal = Goal(
      id: '',
      userId: currentUser.id,
      name: name,
      startDate: DateTime.now(),
    );
    _refreshGoals();
    await _goalsRepository.addGoal(goal);
  }

  Future<void> _refreshGoals() async {
    emit(const GoalsLoadInProgress());
    try {
      final goals = await _goalsRepository.getGoals();
      emit(GoalsLoadSuccess(goals));
    } on UserCanceledException {
      emit(const GoalsStateInitial());
    } catch (e) {
      emit(GoalsLoadFailure(parseErrorMessageFrom(e)));
    }
  }

  Future<void> saveGoalsOrder(List<Goal> goals) {
    return _goalsRepository.saveTimersOrder(goals);
  }
}
