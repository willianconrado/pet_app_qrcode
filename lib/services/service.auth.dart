import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obter usuário atual
  User? get currentUser => _firebaseAuth.currentUser;

  // Stream de mudanças no estado de autenticação
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Login com e-mail e senha (userJoin)
  Future<String?> userJoin(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return _tratarErro(e.code);
    }
  }

  // Cadastro com e-mail e senha (userRegister)
  Future<String?> userRegister({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Criar documento do usuário no Firestore
      await createUserInFirestore(userCredential.user!.uid, name, email, null);

      return null;
    } on FirebaseAuthException catch (e) {
      return _tratarErro(e.code);
    }
  }

  // Logout (logOut)
  Future<String?> logOut() async {
    try {
      await GoogleSignIn().signOut();
      await _firebaseAuth.signOut();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Remover/Deletar conta (removeAccount)
  Future<String?> removeAccount({required String password}) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) return "Usuário não logado";

      // Reautenticação é necessária para deletar conta
      AuthCredential credential =
          EmailAuthProvider.credential(email: user.email!, password: password);
      await user.reauthenticateWithCredential(credential);

      String uid = user.uid;
      await _firestore.collection('users').doc(uid).delete();
      await user.delete();

      return null;
    } on FirebaseAuthException catch (e) {
      return _tratarErro(e.code);
    }
  }

  // Login com Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) return null;

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _firebaseAuth.signInWithCredential(credential);
      }

      // Verifique se o usuário já existe no Firestore
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        await createUserInFirestore(
          userCredential.user!.uid,
          userCredential.user!.displayName ?? '',
          userCredential.user!.email ?? '',
          userCredential.user!.photoURL,
        );
      }

      return userCredential;
    } catch (e) {
      print("Error Sign with Google: $e");
      return null;
    }
  }

  // Criar ou atualizar usuário no Firestore
  Future<void> createUserInFirestore(
      String uid, String name, String email, String? profileImageUrl) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'profileImageUrl': profileImageUrl,
      }, SetOptions(merge: true));
    } catch (e) {
      print("Erro ao criar usuário no Firestore: $e");
    }
  }

  // Redefinir senha (esqueci minha senha)
  Future<String?> changeMyPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return _tratarErro(e.code);
    }
  }

  // Tradução simples de erros comuns
  String _tratarErro(String code) {
    switch (code) {
      case "user-not-found":
        return "Usuário não encontrado.";
      case "wrong-password":
        return "Senha incorreta.";
      case "email-already-in-use":
        return "Este e-mail já está em uso.";
      case "weak-password":
        return "A senha é muito fraca.";
      default:
        return "Ocorreu um erro inesperado: $code";
    }
  }
}
