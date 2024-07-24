import 'package:cases/hive_database/add_screen.dart';
import 'package:cases/hive_database/component/word_card.dart';
import 'package:cases/hive_database/model/word_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabasePage extends StatefulWidget {
  const HiveDatabasePage({super.key});

  @override
  State<HiveDatabasePage> createState() => _HiveDatabasePageState();
}

class _HiveDatabasePageState extends State<HiveDatabasePage> {
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
            "noSQL Hive Database",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: -1,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => AddScreen()),
            );
          },
          child: Icon(
            color: Colors.white,
            Icons.add,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueListenableBuilder(
              valueListenable: Hive.box<WordModel>('word').listenable(),
              builder: (context, Box<WordModel> box, child) {
                return ListView.separated(
                  itemBuilder: (_, index) {
                    final item = box.getAt(index);

                    if (item == null) {
                      return Container(
                        child: Center(
                          child: Text(
                            "아이템이 존재하지 않습니다.",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return WordCard(
                        onBodyTap: () {
                          Get.snackbar(item.engWord, item.korWord);
                        },
                        onCheckTap: () {
                          final newModel = WordModel(
                            id: item.id,
                            engWord: item.engWord,
                            korWord: item.korWord,
                            correctCount: item.correctCount + 1,
                          );
                          box.put(item.id, newModel);
                        },
                        engWord: item.engWord,
                        korWord: item.korWord,
                        correctCount: item.correctCount,
                      );
                    }
                  },
                  separatorBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Divider(),
                    );
                  },
                  itemCount: box.length,
                );
              }),
        ));
  }
}
