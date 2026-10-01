import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miracle_tv/core/constants.dart';
import 'package:miracle_tv/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserModel?> getCurrentUserModel() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    try {
      final doc = await _firestore
          .collection(FirestoreCollections.users)
          .doc(user.uid)
          .get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() ?? {}, user.uid);
      }
    } catch (e) {
      print('Error getting user model: $e');
    }
    return null;
  }

  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        id: credential.user!.uid,
        name: name,
        email: email,
        isAdmin: false,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection(FirestoreCollections.users)
          .doc(credential.user!.uid)
          .set(user.toMap());
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Utilisateur non trouve';
      case 'wrong-password':
        return 'Mot de passe incorrect';
      case 'email-already-in-use':
        return 'Email deja utilise';
      case 'weak-password':
        return 'Mot de passe trop faible';
      case 'invalid-email':
        return 'Email invalide';
      default:
        return 'Erreur: ${e.message}';
    }
  }
}
