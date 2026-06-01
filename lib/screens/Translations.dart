import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Translations extends StatefulWidget {
  const Translations({super.key});

  @override
  State<Translations> createState() => _TranslationsState();
}

class _TranslationsState extends State<Translations> {
  final List<String> _list = List.generate(2, (i)=>'مرحبا'   + 'Translation ' + '${i}');
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
        itemBuilder: (context,index){
          final _item =  _list[index];
          return GestureDetector(
            onTap: (){
              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text('Word'),
                      content: Text(_item),
                      actions: [
                        TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close)
                        )
                      ],
                    );
                  }
              );
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              color: Colors.grey.shade300,

              child: Text(
                _item,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          );
        }
    );
  }
}
