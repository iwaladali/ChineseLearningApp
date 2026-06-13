import 'package:flutter_project/widgets/vocabulary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/providers/vocabulary_provider.dart';
import 'package:flutter_project/providers/speech_provider.dart';
import 'package:provider/provider.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {

  static const Color darkText = Color(0xFF2F3A3F);
  static const Color greyText = Color(0xFF9CA3AF);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Future.microtask(() {
      Provider.of<VocabularyProvider>(context,listen: false,).loadVocabularies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vocabProvider = Provider.of<VocabularyProvider>(context);
    final speechProvider = Provider.of<SpeechProvider>(context);
    var vocabs = vocabProvider.filteredvocabularies;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xFFF8F8F8),
          body: SafeArea(
              child: Center(
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 430),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsetsGeometry.all(24),
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                                  Navigator.pop(context);
                                }, icon: const Icon(Icons.arrow_back)),
                                const Expanded(child: Text('قاموس الكلمات',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: darkText,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),)),
                                IconButton(onPressed: (){
                                  // TODO: Open search mode.
                                }, icon: const Icon(Icons.search))
                              ],
                            ),
                        ),

                        Padding(
                            padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'ابحث عن كلمة...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)
                            )
                          ),
                          onChanged: (arabic_word)async {

                              vocabProvider.filterArabic(arabic_word);
                            setState(() {
                            });
                          }
                            ,
                          // TODO: Filter vocabulary list using VocabularyProvider.
                        ),
                        ),
                        const SizedBox(height: 24,),
                        
                        const Padding(
                            padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('الكلمات الشائعة',
                          style: TextStyle(
                            color: greyText,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),),
                        ),),
                        const SizedBox(height: 18,),
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            children: vocabs.map((ele)=>
                            VocabularyCard.fromMap(ele.GetfromMap(),
                                speechProvider.speak_word,
                                    () {
                                      Navigator.pushNamed(
                                        context,
                                        '/wordDetails',
                                        arguments: ele,
                                      );
                                }
                                ) ).toList(),
                          ),

                        )
                        // TODO: Replace static cards with VocabularyProvider data.
                        // TODO: Load words from Firestore.
                        // TODO: Add pagination if vocabulary grows.
                      ],
                    ),

                ),
              )),
        ));
  }
}

