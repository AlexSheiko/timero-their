import 'package:firebase_auth/firebase_auth.dart';
import 'package:timero/authentication/data/credential.dart';

class ForgotPasswordRepository {
  const ForgotPasswordRepository(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;

  Future<Credential> recoverPassword(String email) async {
    Credential credentials = Credential(null, '');
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      credentials.errorMessage = e.code;
    }
    return credentials;
  }
}
