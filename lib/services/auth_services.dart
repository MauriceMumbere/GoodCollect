import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- Inscription ---
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // --- Connexion ---
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      print("Erreur inattendue de connexion: $e");
      return null;
    }
  }

  // --- Deconnexion ---
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Erreur lors de la déconnexion: $e");
      throw e;
    }
  }
}