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
    );
  }
}
