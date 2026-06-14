// lib/services/profile_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/models/DTO/user_profile.dart';


class ProfileService {
  final _db   = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  // ── جلب البروفايل ─────────────────────────────────
  Future<UserProfile?> getProfile() async {
    print('UID: $_uid');  // شوف إذا الـ uid موجود

    if (_uid == null) return null;

    final doc = await _db.collection('Users').doc(_uid).get();
    print('Doc exists: ${doc.exists}');  // شوف إذا الـ document موجود
    print('Doc data: ${doc.data()}');    // شوف البيانات

    if (!doc.exists) return null;

    return UserProfile.fromMap(doc.id, doc.data()!);
  }
  // ── تحديث البروفايل ───────────────────────────────
  Future<void> updateProfile(UserProfile profile) async {
    if (_uid == null) return;
    await _db.collection('Users').doc(_uid).set(
      profile.toMap(),
      SetOptions(merge: true),
    );
  }

  // ── تحديث التقدم اليومي ───────────────────────────
  Future<void> updateProgress({
    required int wordsLearned,
    required double todayProgress,
  }) async {
    if (_uid == null) return;
    await _db.collection('Users').doc(_uid).update({
      'wordsLearned':  wordsLearned,
      'todayProgress': todayProgress,
    });
  }
}