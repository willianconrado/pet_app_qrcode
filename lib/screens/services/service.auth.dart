import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  registerUser({
    required String email,
    required String password,
    required String name,
  }) {
    _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
