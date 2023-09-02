import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  registerUser({
    required String email,
    required String name,
    required String password,
    required String telephone,
  }) {
    _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
