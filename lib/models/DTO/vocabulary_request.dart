
class VocabularyRequest{
  String arabic;
  String chinese;
  String pinyin;
  String category;
  VocabularyRequest({required this.arabic, required this.chinese,required this.pinyin, required this.category });

  factory VocabularyRequest.fromMap(Map<String, dynamic> map) {
    return VocabularyRequest(
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
