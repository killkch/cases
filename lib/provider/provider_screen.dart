import 'package:cases/provider/challenge_page.dart';
import 'package:cases/provider/setting_page.dart';
import 'package:cases/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider"),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => SettingPage());
            },
            child: const Text('Settings'),
          ),
          TextButton(
            onPressed: () {
              Get.to(() => ChallengePage());
            },
            child: const Text('Challenge'),
          ),
        ],
      ),
      body: Center(
        child: Text(
          context.watch<UserProvider>().userName,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
          ),
        ),
      ),
    );
  }
}
