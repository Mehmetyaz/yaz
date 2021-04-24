import 'package:flutter/material.dart';
import 'package:yaz/yaz.dart';

///
class StateManager extends StatelessWidget {
  ///
  StateManager({Key? key}) : super(key: key);

  ///
  final YazNotifier<int> notifier = 0.notifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Only Build (Text) Many Times"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notifier.value++;
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: YazListenerWidget(
          changeNotifier: notifier,
          builder: (c) {
            return Text(notifier.value.toString());
          },
        ),
      ),
    );
  }
}
