import 'package:firebase_auth/firebase_auth.dart';
import 'package:timero/authentication/data/credential.dart';

class ChangePasswordRepository {
  const ChangePasswordRepository(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;

  Future<Credential> changePassword(String password) async {
    var user = FirebaseAuth.instance.currentUser;
    Credential credentials = Credential(null, '');
    try {
      await user?.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      credentials.errorMessage = e.code;
    }
    return credentials;
  }

  User? getCurrentUser() {
    var user = FirebaseAuth.instance.currentUser;
    return user;
  }
}
