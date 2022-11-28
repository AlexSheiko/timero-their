import 'package:firebase_auth/firebase_auth.dart';

class Credential {
  Credential(this.userCredential, this.errorMessage);

  UserCredential? userCredential;
  String errorMessage;
}
