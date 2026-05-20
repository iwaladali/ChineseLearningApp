import 'package:flutter/material.dart';
import 'package:flutter_project/providers/vocabulary_provider.dart';
import 'package:provider/provider.dart';

class VocabularyShow extends StatelessWidget {
   VocabularyShow({super.key});


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = context.read<VocabularyProvider>();
      provider.loadVocabularies();

   });

    return Scaffold(
     appBar: AppBar(
       title: Text("VocabularyShow",
         style: TextStyle(
           color: Colors.indigo
         ),

       ),
       centerTitle: true,
       backgroundColor: Colors.black12,
     ),
      body:
          Consumer<VocabularyProvider>(
            builder: (context, provider ,_){
              if(provider.isLoading)
                return Center(child: CircularProgressIndicator());
             return Center(
                child:
                Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: provider.vocabularies.map((vocab) =>
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Arabic Word: ${vocab.arabic}'),
                          SizedBox(width: 15,),
                          Text('chinese Word: ${vocab.chinese}'),
                        ],
                      )
                  ).toList(),
                ),
             );
            }
          )

    );
  }
}
