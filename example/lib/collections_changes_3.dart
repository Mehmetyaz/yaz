import 'package:flutter/material.dart';
import 'package:yaz/yaz.dart';

///
class CollectionChanges3 extends StatelessWidget {
  ///
  CollectionChanges3({Key? key}) : super(key: key);

  ///
  final List<YazNotifier<int>> list = [0, 0, 0, 0, 0, 0, 0].listeners;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: YazListenerWidget(
            changeNotifier: list.notifyAll,
            builder: (c) {
              return BuiltNotifier(child: Text("SUM: $sum"));
            }),
      ),
      body: ListView.separated(
        itemCount: list.length,
        itemBuilder: (c, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: CounterWidget3(counter: list[i], index: i),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  ///
  int get sum {
    var i = 0;
    for (var o in list) {
      i += o.value;
    }
    return i;
  }
}

///
class CounterWidget3 extends StatelessWidget {
  ///
  const CounterWidget3({Key? key, required this.counter, required this.index})
      : super(key: key);

  ///
  final YazNotifier<int> counter;

  ///
  final int index;

  @override
  Widget build(BuildContext context) {
    return BuiltNotifier(
      child: Row(
        children: [
          BuiltNotifier(
            child: Container(
              width: 200,
              alignment: Alignment.center,
              child: Text("Index Of $index"),
              margin: const EdgeInsets.symmetric(horizontal: 0),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BuiltNotifier(
                  child: TextButton(
                      onPressed: () {
                        counter.value++;
                      },
                      child: const Text("Counter Increment")),
                ),
                YazListenerWidget(
                    changeNotifier: counter,
                    builder: (c) {
                      return BuiltNotifier(child: Text("${counter.value}"));
                    }),
                BuiltNotifier(
                  child: TextButton(
                      onPressed: () {
                        counter.value--;
                      },
                      child: const Text("Counter1 Decrement")),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
