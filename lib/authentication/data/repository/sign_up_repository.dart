import 'package:firebase_auth/firebase_auth.dart';
import 'package:timero/authentication/data/credential.dart';

class SignUpRepository {
  const SignUpRepository(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;

  Future<Credential> signUp(String email, String password) async {
    Credential credentials = Credential(null, '');
    try {
      credentials.userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      credentials.errorMessage = e.code;
    }
    await _waitUntilUserIsReady();
    return credentials;
  }

  Future<void> _waitUntilUserIsReady() async {
    if (firebaseAuth.currentUser == null) {
      await firebaseAuth
          .userChanges()
          .firstWhere((user) => user != null && user.uid.isNotEmpty);
    }
  }
}
