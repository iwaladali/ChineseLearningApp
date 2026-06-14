// lib/models/user_profile.dart

class UserProfile {
  final String id;
  final String name;
  final String level;
  final int wordsLearned;
  final double todayProgress;

  UserProfile({
    required this.id,
    required this.name,
    required this.level,
    required this.wordsLearned,
    required this.todayProgress,
  });

  factory UserProfile.fromMap(String id, Map<String, dynamic> map) {
    return UserProfile(
      id:            id,
      name:          map['name']          ?? 'مستخدم',
      level:         map['level']         ?? 'مبتدئ',
      wordsLearned:  map['wordsLearned']  ?? 0,
      todayProgress: (map['todayProgress'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
    'name':          name,
    'level':         level,
    'wordsLearned':  wordsLearned,
    'todayProgress': todayProgress,
  };
}