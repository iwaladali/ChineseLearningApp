
class VocabularyResponse{
  String arabic;
  String chinese;
  String pinyin;
  VocabularyResponse({required this.arabic, required this.chinese, required this.pinyin });

  factory VocabularyResponse.fromMap(Map<String, dynamic> map) {
    return VocabularyResponse(
      arabic: map['arabic'] ?? '',
      chinese:  map['chinese']  ?? '',
      pinyin:  map['pinyin']  ?? '',

    );
  }

  Map<String, dynamic> GetfromMap() {

    return  <String, dynamic>{
      'arabic': arabic,
    'chinese':chinese,
    'pinyin':pinyin,

  };
  }



}
