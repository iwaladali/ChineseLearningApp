// lib/services/learned_words_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/models/DTO/learned_word.dart';


class LearnedWordsService {
  final _db  = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  CollectionReference get _ref =>
      _db.collection('Users').doc(_uid).collection('learnedWords');

  // جلب كل الكلمات المتعلمة
  Future<List<LearnedWord>> getLearnedWords() async {
    final snap = await _ref.orderBy('learnedAt', descending: true).get();
    return snap.docs
        .map((d) => LearnedWord.fromMap(d.data() as Map<String, dynamic>))
        .toList();
  }

  // إضافة كلمة جديدة
  Future<void> markAsLearned(LearnedWord word) async {
    print('-=========================================================------');           // تأكد إن الـ uid مش null
    print('UID: $_uid');           // تأكد إن الـ uid مش null
    print('WordId: ${word.wordId}'); // تأكد إن الـ wordId مش فارغ
    await _ref.doc(word.wordId).set(word.toMap());
    print('Done!');
    print('-=========================================================------');           // تأكد إن الـ uid مش null
  }

  // تحقق إذا الكلمة اتعلمت
  Future<bool> isLearned(String wordId) async {
    final doc = await _ref.doc(wordId).get();
    return doc.exists;
  }

  // تحديث السكور بعد تمرين النطق
  Future<void> updateScore(String wordId, int score) async {
    await _ref.doc(wordId).update({'score': score});
  }
}