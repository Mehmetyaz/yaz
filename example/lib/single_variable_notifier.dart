import 'package:flutter/material.dart';
import 'package:yaz/yaz.dart';

///
class SingleVariable extends StatelessWidget {
  ///
  SingleVariable({Key? key}) : super(key: key);

  ///
  final counter = 0.notifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BuiltNotifier(
          child: Column(
            children: [
              BuiltNotifier(
                child: TextButton(
                    onPressed: () {
                      counter.value++;
                    },
                    child: const Text("Increment")),
              ),
              BuiltNotifier(
                child: YazListenerWidget(
                    changeNotifier: counter,
                    builder: (c) {
                      return BuiltNotifier(child: Text("${counter.value}"));
                    }),
              ),
              BuiltNotifier(
                child: TextButton(
                    onPressed: () {
                      counter.value--;
                    },
                    child: const Text("Decrement")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
