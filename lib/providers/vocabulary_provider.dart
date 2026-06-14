import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/services/FirebaseService.dart';
import 'package:flutter_project/models/DTO/vocabulary_response.dart';
import 'package:flutter_project/models/DTO/vocabulary_request.dart';

class VocabularyProvider with ChangeNotifier {
  final FirebaseService _service = FirebaseService();


  List<VocabularyResponse> _vocabularies = [];
  List<VocabularyResponse> _FoodVocabularies = [];
  List<VocabularyResponse> _AnotherVocabularies = [];
  List<VocabularyResponse> _LangVocabularies = [];
  List<VocabularyResponse> _VehicleVocabularies = [];
  bool _isLoading = false;

  List<VocabularyResponse> get vocabularies => _vocabularies;
  List<VocabularyResponse>  filteredvocabularies= [];
  bool get isLoading => _isLoading;

  Future<void> loadVocabularies() async {
    _isLoading = true;
    notifyListeners();

    filteredvocabularies=_vocabularies = await _service.get_Vocabularies();
    List<VocabularyResponse> food=[], another=[], lang=[], vehicle=[];
    for( var vocab in _vocabularies){
      if( vocab.category== 'food' )
        food.add(vocab);
      else if( vocab.category== 'language' )
        lang.add(vocab);
      else if( vocab.category== 'vehicles' )
        vehicle.add(vocab);
      else
        another.add(vocab);
    }
    _FoodVocabularies =food;
    _AnotherVocabularies= another;
    _LangVocabularies= lang;
    _VehicleVocabularies= vehicle;

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addVocabulary( VocabularyRequest req ) async {
    bool res= await _service.add_Vocabulary(req);
    return res;
  }
  Future<void> addVocabAll()async{
    String jsonString = await rootBundle.loadString('lib/models/Data/dataHsk_1_to_3.json');

    var data = jsonDecode(jsonString);

    for(var word in data['HSK-1']){
      addVocabulary( VocabularyRequest(arabic: word['arabic'][0], chinese: word['word'],
          pinyin: word['pinyin'], category: word['category']));
    }

  }
  void filterArabic(String word)  {
  if(word==null|| word.isEmpty)
    filteredvocabularies= vocabularies;
  else {
    filteredvocabularies = _vocabularies.where((vocab) {
      return vocab.arabic.startsWith(word);
    }).toList();
  }


  }
}