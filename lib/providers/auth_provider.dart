import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

enum AuthStatus { idle, loading, error }

class AuthProvider with ChangeNotifier {
  final AuthService authService;

  AuthProvider({required this.authService});

  AuthStatus _status = AuthStatus.idle;
  String? _errorMessage;

  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _status == AuthStatus.loading;

  // 🔥 أهم تغيير: مصدر الحقيقة هو Firebase
  bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;

  // ---------------- SIGN IN ----------------
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading();

      await authService.signInWithEmail(
        email: email,
        password: password,
      );

      _setIdle();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // ---------------- REGISTER ----------------
  Future<bool> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      _setLoading();

      await authService.registerWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );

      _setIdle();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // ---------------- SIGN OUT ----------------
  Future<void> signOut() async {
    try {
      await authService.signOut();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  // ---------------- RESET PASSWORD ----------------
  Future<bool> resetPassword(String email) async {
    try {
      _setLoading();
      await authService.resetPassword(email);
      _setIdle();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // ---------------- STATE ----------------
  void _setLoading() {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void _setIdle() {
    _status = AuthStatus.idle;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _status = AuthStatus.error;
    _errorMessage = message;
    notifyListeners();
  }
}