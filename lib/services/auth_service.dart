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
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user == null) {
        throw Exception("Login failed: user is null");
      }

      final doc = await _firestore.collection('Users').doc(user.uid).get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      } else {
        throw Exception("User not found in Firestore");
      }
    } catch (e) {
      print("LOGIN ERROR: $e");
      rethrow;
    }
  }

  // ---------------- REGISTER ----------------
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user == null) {
        throw Exception("User creation failed");
      }

      final newUser = UserModel(
        uid: user.uid,
        email: email,
        displayName: displayName,
        role: 'student',
        photoUrl: null,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('Users')
          .doc(user.uid)
          .set(newUser.toMap());

      return newUser;
    } catch (e) {
      print("REGISTER ERROR: $e");
      rethrow;
    }
  }

  // ---------------- CURRENT USER ----------------
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _auth.currentUser;

      if (user == null) return null;

      final doc = await _firestore.collection('Users').doc(user.uid).get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      }

      return null;
    } catch (e) {
      print("GET CURRENT USER ERROR: $e");
      return null;
    }
  }

  // ---------------- RESET PASSWORD ----------------
  Future resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // ---------------- SIGN OUT ----------------
  Future signOut() async {
    await _auth.signOut();
  }
}