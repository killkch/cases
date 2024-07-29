import 'package:cases/provider/counter_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.black87,
        title: Text(
          "Challenge Page",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: -1,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.watch<CounterProvider>().value.toString(),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterProvider>().incrementCounter();
            },
            child: Icon(Icons.add),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterProvider>().decrementCounter();
            },
            child: Icon(Icons.remove),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
