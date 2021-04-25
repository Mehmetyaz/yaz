import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yaz/yaz.dart';

///
class StringChange extends StatelessWidget {
  ///
  StringChange({Key? key}) : super(key: key);

  ///
  final count = 0.notifier;

  @override
  Widget build(BuildContext context) {
    var timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (count.value == 3) {
        count.value = 0;
      } else {
        count.value++;
      }
    });
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            YazListenerWidget(
                onDispose: () {
                  timer.cancel();
                },
                changeNotifier: count,
                builder: (c) {
                  return Text(('.' * count.value));
                }),
          ],
        ),
      ),
    );
  }
}
