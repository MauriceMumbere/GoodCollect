// lib/services/auth_service.dart
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
      // Optionnel : Ajouter le nom d'affichage après l'inscription
      // await result.user?.updateDisplayName(name);
      return result.user;
    } on FirebaseAuthException catch (e) {
      // Propagation de l'erreur pour la gestion dans l'UI
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
      // Propagation de l'erreur pour la gestion dans l'UI
      rethrow;
    } catch (e) {
      print("Erreur inattendue de connexion: $e");
      return null;
    }
  }
}