import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

 Future<String?> userJoin({required String email, required String password}) async {
  try {
  await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
} on FirebaseAuthException catch (e) {
  switch(e.code ){
    case "user-not-found":
    return "O email não está cadastrado";
    case "wrong-password":
    return "Senha incorreta";
  }
  return e.code;
}
return null;
  }

  Future<String?>  userRegister(
      {required String email,
      required String password,
      required String name}) async {
    try {
  UserCredential userCredential = await _firebaseAuth
      .createUserWithEmailAndPassword(email: email, password: password);
  
  await userCredential.user!.updateDisplayName(name);
  print("Funfou");
} on FirebaseAuthException catch (e) {
  switch(e.code) {
    case "email-already-in-use":
    return "o email já está em uso";
  }
  return e.code;
}

  }
  Future<String?> changeMyPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if(e.code == "user-not-found"){
        return "E-mail não cadastrado.";
      }
      return e.code;
    }
  return null;
  }
}
