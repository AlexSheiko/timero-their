import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timero/current_user/data/current_user_repository.dart';
import 'package:timero/home/data/model/goal.dart';
import 'package:timero/user_details/model/user_details_repository.dart';

class GoalsRepository {
  const GoalsRepository(
    this._firebaseFirestore,
    this._currentUserRepository,
    this._userDetailsRepository,
  );

  final CurrentUserRepository _currentUserRepository;
  final FirebaseFirestore _firebaseFirestore;
  final UserDetailsRepository _userDetailsRepository;

  Future<List<Goal>> getGoals() async {
    final currentUser = _currentUserRepository.currentUser;

    final snapshot = await _firebaseFirestore
        .collection('goals')
        .where('userId', isEqualTo: currentUser.id)
        .get();

    final result = snapshot.docs.map((doc) {
      final json = doc.data();
      _makeIdExplicit(json, doc);
      // _autoParseDatesIn(json);
      return Goal.fromMap(json);
    }).toList();
    final user = await _userDetailsRepository.getUserDetails();
    return _sortBasedOnDragToReorder(user?.timersOrder, result);
  }

  Future<void> addDays(String days, String id) async {
    await _firebaseFirestore.collection('goals').doc(id).update({
      'goalDays': days,
    });
  }

  Future<void> addName(String name, String id) async {
    await _firebaseFirestore.collection('goals').doc(id).update({
      'name': name,
    });
  }

  Future<void> addReset(Goal goal) async {
    final newReset = DateTime.now().toIso8601String();
    if (goal.resets.isEmpty) {
      await _firebaseFirestore.collection('goals').doc(goal.id).update({
        'resets': newReset,
      });
    } else {
      String result = '';
      for (final reset in goal.resets) {
        result += '${reset}A';
      }
      result += '${newReset}A';
      await _firebaseFirestore.collection('goals').doc(goal.id).update({
        'resets': result,
      });
    }
  }

  Future<void> addGoal(Goal goal) async {
    final json = Goal.toMap(goal);
    json['id'] = null; // Firestore will generate an ID for us
    await _firebaseFirestore
        .collection('goals')
        .add(_onlyNonNullFieldsToAvoidOverridingNewServerDataWithNulls(json));
  }

  Future<void> deleteGoal(Goal goal) async {
    await _firebaseFirestore.collection('goals').doc(goal.id).delete();
  }

  Future<void> deleteDays(String id) async {
    await _firebaseFirestore.collection('goals').doc(id).update({
      'goalDays': 0,
    });
  }

  void _makeIdExplicit(Map<String, dynamic> json, DocumentSnapshot doc) {
    json['id'] = doc.id;
  }

  Map<String, dynamic>
      _onlyNonNullFieldsToAvoidOverridingNewServerDataWithNulls(
          Map<String, dynamic> json) {
    final Map<String, dynamic> updatedJson = {};
    json.forEach((key, value) {
      if (value != null) {
        updatedJson[key] = value;
      }
    });
    return updatedJson;
  }

  Future<void> saveTimersOrder(List<Goal> timers) async {
    final ids = timers.map((goal) => goal.id).toList();
    await _userDetailsRepository.saveTimersOrder(ids);
  }

  List<Goal> _sortBasedOnDragToReorder(
      List<String>? goalsOrder, List<Goal> goals) {
    if (goalsOrder != null) {
      final sortedGoals = goals.toList()
        ..sort((a, b) =>
            goalsOrder.indexOf(a.id).compareTo(goalsOrder.indexOf(b.id)));
      return sortedGoals;
    } else {
      return goals;
    }
  }
}
