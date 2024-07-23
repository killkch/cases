// ignore_for_file: prefer_const_constructors

import 'package:cases/hive_database/model/word_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'package:cases/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //? init HIVE !!!
  await Hive.initFlutter();
  Hive.registerAdapter(WordModelAdapter());
  await Hive.openBox<WordModel>('word');

  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 5));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
