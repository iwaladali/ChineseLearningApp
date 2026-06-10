import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/models/DTO/vocabulary_response.dart';
import 'package:flutter_project/models/DTO/vocabulary_request.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<VocabularyResponse>> get_Vocabularies() async {
    QuerySnapshot snapshot =
    await _firestore.collection('Vocabulary').get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      return VocabularyResponse(
        arabic: data['arabic'],
        chinese: data['chinese'],
      );
    }).toList();
  }

  Future<bool> add_Vocabulary(VocabularyRequest req) async {
    try {
      await _firestore.collection('Vocabulary').add({
        'arabic': req.arabic,
        'chinese': req.chinese,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}