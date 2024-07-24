import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//? [2] ConsumerWidget setting
class RiverpodScreen extends ConsumerWidget {
  RiverpodScreen({super.key});
  final counterProvider = StateNotifierProvider((ref) => Counter());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    ref.listen(counterProvider, (prev, next) {
      print("현재 상테 $prev , $next");
    });

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.black87,
        title: const Text(
          'RiverPod Sample',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: -1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Count : ${count.toString()}"),
            TextButton(
              //? [4] riverpod setting...
              onPressed: () => ref.watch(counterProvider.notifier).increment(),
              child: Text(
                "증가 하기",
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: -1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//? [3]
class Counter extends StateNotifier {
  Counter() : super(0);

  void increment() => state++;
}
