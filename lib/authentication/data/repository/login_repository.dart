import 'package:firebase_auth/firebase_auth.dart';
import 'package:timero/authentication/data/credential.dart';

class LoginRepository {
  const LoginRepository(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;

  Future<Credential> loginWithEmailPassword(
    String email,
    String password,
  ) async {
    Credential credentials = Credential(null, '');
    try {
      credentials.userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      credentials.errorMessage = e.code;
    }
    return credentials;
  }
}
