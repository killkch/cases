import 'package:cases/hive_database/model/word_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  //?

  String engWord = '';
  String korWord = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black87,
        title: Text(
          "Add Word",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: -1,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextField(
                    onChanged: (val) {
                      engWord = val;
                    },
                    decoration: InputDecoration(
                      labelText: '영어 단어',
                    ),
                  ),
                  TextField(
                    onChanged: (val) {
                      korWord = val;
                    },
                    decoration: InputDecoration(
                      labelText: '한글 단어',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              width: MediaQuery.of(context).size.width,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  surfaceTintColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () async {
                  final box = await Hive.openBox<WordModel>('word');
                  int id = 0;

                  if (box.isNotEmpty) {
                    final prevItem = box.getAt(box.length - 1);

                    if (prevItem != null) {
                      id = prevItem.id + 1;
                    }
                  }

                  box.put(
                    id,
                    WordModel(
                      id: id,
                      engWord: engWord,
                      korWord: korWord,
                      correctCount: 0,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: Text(
                  "저장",
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: -1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
