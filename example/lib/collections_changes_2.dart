import 'package:flutter/material.dart';
import 'package:yaz/yaz.dart';

///
class CollectionChanges2 extends StatelessWidget {
  ///
  CollectionChanges2({Key? key}) : super(key: key);

  ///
  final YazList<int> list = [0, 0, 0, 0, 0, 0, 0].listenAll;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: YazListenerWidget(
            changeNotifier: list,
            builder: (c) {
              return BuiltNotifier(child: Text("SUM: $sum"));
            }),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (c, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: CounterWidget(counterList: list, index: i),
          );
        },
      ),
    );
  }

  ///
  int get sum {
    var i = 0;
    for (var o in list.value) {
      i += o;
    }
    return i;
  }
}

///
class CounterWidget extends StatelessWidget {
  ///
  const CounterWidget(
      {Key? key, required this.counterList, required this.index})
      : super(key: key);

  ///
  final YazList<int> counterList;

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
                        counterList[index]++;
                      },
                      child: const Text("Counter Increment")),
                ),
                YazListenerWidget(
                    changeNotifier: counterList,
                    builder: (c) {
                      return BuiltNotifier(
                          child: Text("${counterList[index]}"));
                    }),
                BuiltNotifier(
                  child: TextButton(
                      onPressed: () {
                        counterList[index]--;
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
