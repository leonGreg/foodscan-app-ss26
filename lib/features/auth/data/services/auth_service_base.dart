import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_scan/features/auth/data/models/user_model.dart';

abstract class AuthServiceBase {
  Stream<User?> get authStateChanges;
  User? get currentFirebaseUser;

  Future<AppUser> signInWithEmail(String email, String password);
  Future<AppUser> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  });
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> updateDisplayName(String displayName);
}
