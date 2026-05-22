class PronunciationResult {
  final String wordHeard;
  final int accuracy;
  final String feedback;
  final String tip;
  final String grade;

  PronunciationResult({
    required this.wordHeard,
    required this.accuracy,
    required this.feedback,
    required this.tip,
    required this.grade,
  });

  factory PronunciationResult.fromMap(Map<String, dynamic> map) {
    return PronunciationResult(
      wordHeard: map['word_heard'] ?? '',
      accuracy:  map['accuracy']  ?? 0,
      feedback:  map['feedback']  ?? '',
      tip:       map['tip']       ?? '',
      grade:     map['grade']     ?? 'Poor',
    );
  }
}
 