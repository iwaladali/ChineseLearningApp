import 'package:flutter/material.dart';
import 'package:flutter_project/models/DTO/vocabulary_response.dart';
import 'package:flutter_project/providers/speech_provider.dart';
import 'package:flutter_project/widgets/word_info_card.dart';
import 'package:provider/provider.dart';

class WordDetailsScreen extends StatelessWidget {
  const WordDetailsScreen({super.key});

  static const Color primaryRed = Color(0xFFE53935);
  static const Color lightRed = Color(0xFFFDEAEA);
  static const Color darkText = Color(0xFF2F3A3F);
  static const Color greyText = Color(0xFF9CA3AF);
  static const Color yellow = Color(0xFFD4A514);

  @override
  Widget build(BuildContext context) {
    final speechProvider = Provider.of<SpeechProvider>(context);
    final vocab =
    ModalRoute.of(context)!.settings.arguments
    as VocabularyResponse;
    // TODO: Receive selected Word model from previous screen.
    // TODO: Replace these static values with selected word data.

    final String hanzi = vocab.chinese;
    final String pinyin = vocab.pinyin;
    final String arabic = vocab.arabic;
    
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xFFF8F8F8),
          body: SafeArea(
              child: Center(
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 430),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      SizedBox(height: 18,),
                      
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // TODO: Share selected word.
                            },
                            icon: const Icon(Icons.share),
                          ),

                          const Expanded(
                            child: Center(
                              child: Text(
                                'تفاصيل الكلمة',
                                style: TextStyle(
                                  color: darkText,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28,),
                      
                      WordInfoCard(
                          child: Column(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: const BoxDecoration(
                                  color: lightRed,
                                  shape: BoxShape.circle
                                ),
                                child: const Icon(
                                    Icons.translate,
                                color: primaryRed,
                                size: 58,),
                              ),
                              const SizedBox(height: 34,),
                               Text(
                                hanzi,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: darkText,
                                  fontSize: 52,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              
                              const SizedBox(height: 22,),
                              
                               Text(
                                pinyin,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: yellow,
                                  fontSize: 26,
                                  height: 1.4
                                ),
                              ),
                              
                              const SizedBox(height: 28,),
                              
                              Container(
                                height: 1,
                                width: 240,
                                color: Color(0xFFE5E7EB),
                              ),

                              const SizedBox(height: 28,),

                               Text(
                                arabic,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: greyText,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4
                                ),
                              )
                            ],
                          ) ),

                      const SizedBox(height: 34,),

                      const Text(  'تفاعل مع الكلمة',
                      style: TextStyle(
                        color: greyText,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),),
                      
                      SizedBox(height: 20,),
                      
                      SizedBox(
                        width: 220,
                        height: 58,
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryRed,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                              )
                            ),
                            onPressed: (){
                              // TODO: Play pronunciation using SpeechProvider.
                              // TODO: Play selected word audio.
                              speechProvider.speak_word(hanzi);

                            },
                            icon: const Icon(Icons.volume_up),
                            label: const Text('استمع للنطق',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),)),
                      ),

                      const SizedBox(height: 22,),

                      TextButton.icon(onPressed: (){
                       // TODO: Navigate to pronunciation training screen.
                        // TODO: Record user voice.
                        // TODO: Compare pronunciation result.
                        Navigator.pushNamed(
                          context,
                          '/PronunciationTrainingScreen',
                          arguments: vocab,
                        );

                      },
                      icon: const Icon(
                        Icons.mic,
                        color: primaryRed,
                      ), 
                          label: Text('تدرب على النطق',
                          style: TextStyle(
                            color: primaryRed,
                            fontSize: 18,
                            fontWeight:  FontWeight.w600
                          ),)),
                      
                      const SizedBox(height: 34,),
                      
                      WordInfoCard(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: yellow,
                              ),
                              SizedBox(width: 8,),
                              Text('مثال على الاستخدام',
                              style: TextStyle(
                                color: darkText,
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                              ),)
                            ],
                          ),

                          SizedBox(height: 18,),

                          Text(
                            hanzi,
                            style: TextStyle(
                              color: darkText,
                              fontSize: 20
                            ),
                          ),

                          SizedBox(height: 12,),

                          Text(
                            arabic,
                            style: TextStyle(
                              color: greyText,
                              fontSize: 16
                            ),
                          ),
                          // TODO: Replace with real example sentence from Firestore.
                          // TODO: Load example from VocabularyProvider.
                        ],
                      ))
                    ],
                  ),
                ),),
              )),
        ))  ;
  }
}
