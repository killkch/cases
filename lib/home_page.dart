import 'package:cases/hive_database/hive_database_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //?

  final storageBox = GetStorage();
  //?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'Cases',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: -1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.red,
            ),
            title: Text(
              'Hive Database',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
                letterSpacing: -1,
              ),
            ),
            onTap: () {
              print('information is clicked');
              Get.to(() => HiveDatabasePage());
            },
            // trailing: Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              color: Colors.grey[850],
            ),
            title: const Text('장바구니'),
            onTap: () {
              print('cart is clicked');
            },
          ),
        ],
      ),
    );
  }
}