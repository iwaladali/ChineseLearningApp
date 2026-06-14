// lib/models/user_profile.dart

class UserProfile {
  final String id;
  final String displayName;
  final String level;
  final int wordsLearned;
  final double todayProgress;

  UserProfile({
    required this.id,
    required this.displayName,
    required this.level,
    required this.wordsLearned,
    required this.todayProgress,
  });

  factory UserProfile.fromMap(String id, Map<String, dynamic> map) {
    return UserProfile(
      id:            id,
      displayName:          map['displayName']          ?? 'مستخدم',
      level:         map['level']         ?? 'مبتدئ',
      wordsLearned:  map['wordsLearned']  ?? 0,
      todayProgress: (map['todayProgress'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
    'displayName':          displayName,
    'level':         level,
    'wordsLearned':  wordsLearned,
    'todayProgress': todayProgress,
  };
}