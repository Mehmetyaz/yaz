import 'package:flutter/material.dart';
import 'package:yaz/yaz.dart';

///
class SingleVariable extends StatelessWidget {
  ///
  SingleVariable({Key? key}) : super(key: key);

  ///
  final YazNotifier<int> counter = 0.notifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  counter.value++;
                },
                child: const Text("Increment")),
            counter.builder((context) =>
                Text("${counter.value}")),
            TextButton(
                onPressed: () {
                  counter.value--;
                },
                child: const Text("Decrement"))
          ],
        ),
      ),
    );
  }
}
