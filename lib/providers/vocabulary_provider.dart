import 'package:flutter/material.dart';
import 'package:flutter_project/services/firebase_service.dart';
import 'package:flutter_project/models/DTO/vocabulary_response.dart';
import 'package:flutter_project/models/DTO/vocabulary_request.dart';

class VocabularyProvider with ChangeNotifier {
  final FirebaseService _service = FirebaseService();


  List<VocabularyResponse> _vocabularies = [];
  bool _isLoading = false;

  List<VocabularyResponse> get vocabularies => _vocabularies;
  bool get isLoading => _isLoading;

  Future<void> loadVocabularies() async {
    _isLoading = true;
    notifyListeners();

    _vocabularies = await _service.get_Vocabularies();

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addVocabulary( VocabularyRequest req ) async {
    bool res= await _service.add_Vocabulary(req);
    return res;
  }

}