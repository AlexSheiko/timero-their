import 'package:firebase_auth/firebase_auth.dart';
import 'package:timero/authentication/data/credential.dart';

class SettingsRepository {
  const SettingsRepository(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;

  Future<Credential> logOut() async {
    Credential credentials = Credential(null, '');
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      credentials.errorMessage = e.code;
    }
    return credentials;
  }

  String getEmail() {
    String email = '';
    email = (FirebaseAuth.instance.currentUser?.email)!;
    return email;
  }
}
