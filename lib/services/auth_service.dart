import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ---------------- SIGN IN ----------------
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      print("TRY LOGIN: $email");

      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("LOGIN SUCCESS: ${result.user?.uid}");

      final user = result.user!;

      final doc = await _firestore.collection('users').doc(user.uid).get();

      print("FIRESTORE CHECK DONE");

      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      }

      return UserModel(
        uid: user.uid,
        email: user.email ?? email,
        displayName: '',
        photoUrl: null,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      print("LOGIN ERROR: $e"); // 🔥 مهم جداً
      rethrow;
    }
  }
  // ---------------- REGISTER ----------------
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user!;

    final newUser = UserModel(
      uid: user.uid,
      email: email,
      displayName: displayName,
      photoUrl: null,
      createdAt: DateTime.now(),
    );

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(newUser.toMap());
    } catch (e) {
      print("Firestore write failed: $e");
    }

// تسجيل خروج مباشرة بعد إنشاء الحساب
    await _auth.signOut();

    return newUser;
  }

  // ---------------- CURRENT USER ----------------
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _auth.currentUser;

      if (user == null) return null;

      final doc =
      await _firestore.collection('users').doc(user.uid).get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      }

      return UserModel(
        uid: user.uid,
        email: user.email ?? '',
        displayName: '',
        photoUrl: null,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      return null;
    }
  }

  // ---------------- RESET PASSWORD ----------------
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // ---------------- SIGN OUT ----------------
  Future<void> signOut() async {
    await _auth.signOut();
  }
}