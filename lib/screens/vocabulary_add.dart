import 'package:flutter/material.dart';
import 'package:flutter_project/models/DTO/vocabulary_request.dart';
import 'package:flutter_project/providers/vocabulary_provider.dart';
import 'package:provider/provider.dart';


import 'AppDrawer.dart';

class VocabularyAdd extends StatelessWidget {
   VocabularyAdd({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _arabicController = TextEditingController();
  final TextEditingController _chineseController = TextEditingController();
  final TextEditingController _pinyinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vocab_provider = context.watch<VocabularyProvider>();

    return
    Scaffold(
      appBar: AppBar(
        title:  Text('Arabic & Chinese Form'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  // vocab_provider.addVocabAll();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                   Colors.grey,
                  foregroundColor: Colors.white,
                ),
                child: Text("Add All"),
              ),
              SizedBox(height: 20),

              // ── Field 1: Arabic only ────────────────────────────────
              TextFormField(
                controller: _arabicController,
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Arabic Word',
                  hintText: 'أدخل كلمة عربية',
                  hintTextDirection: TextDirection.rtl,
                  prefixIcon: Icon(Icons.translate),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Arabic word is required.';
                  }
                  // Arabic Unicode block: U+0600–U+06FF (includes diacritics & spaces)
                  final arabicRegex = RegExp(r'^[\u0600-\u06FF\s]+$');
                  if (!arabicRegex.hasMatch(value.trim())) {
                    return 'Only Arabic characters are allowed.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // ── Field 2: Chinese only ───────────────────────────────
              TextFormField(
                controller: _chineseController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Chinese Word',
                  hintText: '请输入中文字符',
                  prefixIcon: Icon(Icons.language),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Chinese word is required.';
                  }
                  // CJK Unified Ideographs: U+4E00–U+9FFF
                  // CJK Extension A:        U+3400–U+4DBF
                  // CJK Compatibility:      U+F900–U+FAFF
                  final chineseRegex = RegExp(r'^[\u4E00-\u9FFF\u3400-\u4DBF\uF900-\uFAFF\s]+$');
                  if (!chineseRegex.hasMatch(value.trim())) {
                    return 'Only Chinese characters are allowed.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

                TextFormField(
                controller: _pinyinController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'English Word',
                  hintText: 'Enter the pinyin',
                  prefixIcon: Icon(Icons.language),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Chinese word is required.';
                  }

                  final  pinyinRegex = RegExp(
                    r'^[a-zA-ZāáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜüÜ\s]+$',
                  );
                  if (!pinyinRegex.hasMatch(value.trim())) {
                    return 'Only English and Latin characters are allowed.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              // ── Submit button ───────────────────────────────────────
              FilledButton.icon(
                onPressed:() async {

                if (_formKey.currentState!.validate()) {
                VocabularyRequest req=VocabularyRequest(
                arabic: _arabicController.text,
                chinese: _chineseController.text,
                pinyin: _pinyinController.text,
                    category:""
                );

                bool res= await vocab_provider.addVocabulary(req);
                  String msg="";
                if(res)
                  msg="The ${_arabicController.text} & ${_chineseController.text} Has Added";
                else
                  msg="The ${_arabicController.text} & ${_chineseController.text} Has Added";

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                        Text(msg)
                      ,
                      backgroundColor: Colors.green,
                    ),
                  );
                }

                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Submit'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
