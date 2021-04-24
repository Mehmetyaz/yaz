import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yaz/yaz.dart';

///
class StateManager extends StatelessWidget {
  ///
  StateManager({Key? key}) : super(key: key);

  ///
  final YazNotifier<int> notifier1 = 0.notifier;

  ///
  final YazNotifier<int> notifier2 = 0.notifier;

  ///
  final YazList<int> list = [0, 1].listenAll;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Only Build (Text) Many Times"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Random().nextBool()) {
            list.first++;
          } else {
            list.last--;
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: YazListenerWidget(
          changeNotifier: list,
          builder: (c) {
            return Text((list[0] + list[1]).toString());
          },
        ),
      ),
    );
  }
}
