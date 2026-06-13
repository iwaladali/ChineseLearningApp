
class VocabularyResponse{
  String arabic;
  String chinese;
  String pinyin;
  String category;
  VocabularyResponse({required this.arabic, required this.chinese,
    required this.pinyin, required this.category });

  factory VocabularyResponse.fromMap(Map<String, dynamic> map) {
    return VocabularyResponse(
      arabic: map['arabic'] ?? '',
      chinese:  map['chinese']  ?? '',
      pinyin:  map['pinyin']  ?? '',
      category:  map['category']  ?? '',

    );
  }

  Map<String, dynamic> GetfromMap() {

    return  <String, dynamic>{
      'arabic': arabic,
    'chinese':chinese,
    'pinyin':pinyin,
      'category':category,

  };
  }



}
