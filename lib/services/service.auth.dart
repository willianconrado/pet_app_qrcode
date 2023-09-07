import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String?> registerUser({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
  UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, password: password);
  
    await userCredential.user!.updateDisplayName(name);

    return null;
} on FirebaseAuthException catch (e) {
  if (e.code == "email-already-in-use") {
    return("O usuário já está cadastrado");
  }
  return "Erro desconhecido";
}
  }
}
