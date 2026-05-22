
class VocabularyRequest{
  String arabic;
  String chinese;
  String pinyin;
  VocabularyRequest({required this.arabic, required this.chinese,required this.pinyin });

  factory VocabularyRequest.fromMap(Map<String, dynamic> map) {
    return VocabularyRequest(
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
