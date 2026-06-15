// lib/providers/profile_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_project/models/DTO/user_profile.dart';

import '../services/profile_service.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileService _service = ProfileService();

  UserProfile? profile;
  bool isLoading = false;
  String? errorMessage;

  // ── جلب البروفايل ─────────────────────────────────
  Future<void> loadProfile() async {
    isLoading = true;
    notifyListeners();

    try {
      profile = await _service.getProfile();
    } catch (e) {
      errorMessage = 'Failed to load profile: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  // ── تحديث التقدم اليومي ───────────────────────────
  Future<void> updateProgress({
    required int wordsLearned,
    required double todayProgress,
  }) async {
    await _service.updateProgress(
      wordsLearned:  wordsLearned,
      todayProgress: todayProgress,
    );

    // تحديث محلي بدون ما نرجع لـ Firestore
    if (profile != null) {
      profile = UserProfile(
        id:            profile!.id,
        displayName:          profile!.displayName,
        level:         profile!.level,
        wordsLearned:  wordsLearned,
        todayProgress: todayProgress,
      );
      notifyListeners();
    }
  }
}