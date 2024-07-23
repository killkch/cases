import 'package:cases/hive_database/add_screen.dart';
import 'package:cases/hive_database/component/word_card.dart';
import 'package:flutter/material.dart';

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
          child: ListView.separated(
            itemBuilder: (_, index) {
              return WordCard(
                onBodyTap: () {},
                onCheckTap: () {},
                engWord: 'test',
                korWord: '테스트',
                correctCount: 0,
              );
            },
            separatorBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Divider(),
              );
            },
            itemCount: 50,
          ),
        ));
  }
}
