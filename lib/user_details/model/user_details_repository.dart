import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timero/current_user/data/current_user_repository.dart';
import 'package:timero/user_details/model/user_details.dart';

class UserDetailsRepository {
  const UserDetailsRepository(
    this._currentUserRepository,
    this._firebaseFirestore,
  );

  final CurrentUserRepository _currentUserRepository;
  final FirebaseFirestore _firebaseFirestore;

  Future<UserDetails?> getUserDetails() {
    final currentUser = _currentUserRepository.currentUser;
    return _firebaseFirestore
        .collection('users')
        .doc(currentUser.id)
        .get()
        .then((doc) {
      final json = doc.data();
      if (json != null) {
        _makeIdExplicit(json, doc);
        final userDetails = UserDetails.fromJson(json);
        return userDetails;
      } else {
        return null;
      }
    });
  }

  Future<void> saveTimersOrder(List<String> ids) async {
    final currentUser = _currentUserRepository.currentUser;
    await _firebaseFirestore.collection('users').doc(currentUser.id).set({
      'timersOrder': ids,
    }, SetOptions(merge: true));
  }

  void _makeIdExplicit(Map<String, dynamic> json, DocumentSnapshot doc) {
    json['id'] = doc.id;
  }
}
