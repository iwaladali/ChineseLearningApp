import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/DTO/vocabulary_response.dart';
import 'package:flutter_project/models/DTO/vocabulary_request.dart';

class FirebaseService {

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<VocabularyResponse>> get_Vocabularies() async {
    List<VocabularyResponse> resp=[];
      QuerySnapshot snapshot= await _firestore.collection('Vocabulary').get();

    resp= snapshot.docs.map((doc)=>VocabularyResponse.fromMap(doc.data() as Map<String, dynamic>)
    ).toList();

      return resp;
}

  Future<bool> add_Vocabulary( VocabularyRequest req ) async {
    try{
     Map<String, dynamic> vocab= req.GetfromMap();

   await _firestore.collection('Vocabulary').add(vocab);
      return true;
    }
    catch(e){
      return false;
    }
  }
}

