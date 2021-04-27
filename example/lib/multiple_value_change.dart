import 'package:flutter/material.dart';
import 'package:yaz/yaz.dart';

///
class MultipleValueChange extends StatelessWidget {
  ///
  MultipleValueChange({Key? key}) : super(key: key);

  ///
  final counter1 = 0.notifier;

  ///
  final counter2 = 0.notifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BuiltNotifier(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildCounter1(),
              MultipleChangeNotifier([counter1, counter2]).builder((context) =>
                  BuiltNotifier(
                      child: Text("SUM : ${counter1.value + counter2.value}"))),
              buildCounter2(),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget buildCounter1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BuiltNotifier(
          child: TextButton(
              onPressed: () {
                counter1.value++;
              },
              child: const Text("Counter1 Increment")),
        ),
        counter1.builder(
            (context) => BuiltNotifier(child: Text("${counter1.value}"))),
        BuiltNotifier(
          child: TextButton(
              onPressed: () {
                counter1.value--;
              },
              child: const Text("Counter1 Decrement")),
        )
      ],
    );
  }

  ///
  Widget buildCounter2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BuiltNotifier(
          child: TextButton(
              onPressed: () {
                counter2.value++;
              },
              child: const Text("Counter2 Increment")),
        ),
        counter2.builder(
            (context) => BuiltNotifier(child: Text("${counter2.value}"))),
        BuiltNotifier(
          child: TextButton(
              onPressed: () {
                counter2.value--;
              },
              child: const Text("Counter2 Decrement")),
        )
      ],
    );
  }
}
