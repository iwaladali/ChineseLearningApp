
class VocabularyResponse{
  String id;
  String arabic;
  String chinese;
  String pinyin;
  String category;
  VocabularyResponse({required this.id, required this.arabic, required this.chinese,
    required this.pinyin, required this.category });

  factory VocabularyResponse.fromMap(String docId, Map<String, dynamic> map) {
    return VocabularyResponse(
      id:       docId,
      arabic:   map['arabic']   ?? '',
      chinese:  map['chinese']  ?? '',
      pinyin:   map['pinyin']   ?? '',
      category: map['category'] ?? '',
    );
  }

  Map<String, dynamic> GetfromMap() {

    return  <String, dynamic>{
      'id':id,
      'arabic': arabic,
    'chinese':chinese,
    'pinyin':pinyin,
      'category':category,

  };
  }



}
