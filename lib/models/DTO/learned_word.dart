// lib/models/learned_word.dart
class LearnedWord {
  final String wordId;
  final String chinese;
  final int score;

  LearnedWord({
    required this.wordId,
    required this.chinese,
    required this.score,
  });

  factory LearnedWord.fromMap(Map<String, dynamic> map) {
    return LearnedWord(
      wordId:    map['wordId']    ?? '',
      chinese:   map['chinese']   ?? '',
      score:     map['score']     ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
    'wordId':    wordId,
    'chinese':   chinese,
    'score':     score,
  };
}