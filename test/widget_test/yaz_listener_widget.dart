import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaz/yaz.dart';

void main() {
  testWidgets("Works with single notifier", (tester) async {
    var counter = 0.notifier;
    var buildCount = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: YazListenerWidget(
            changeNotifier: counter,
            builder: (c) {
              buildCount++;
              return Text(counter.value.toString());
            }),
      ),
    ));

    /// first build
    expect(buildCount, 1);
    expect(find.text("0"), findsOneWidget);

    /// wait other frame
    await tester.pump();
    expect(buildCount, 1);

    counter.value++;

    await tester.pump();

    expect(buildCount, 2);
    expect(find.text("1"), findsOneWidget);

    ///
    counter.value = 50;
    await tester.pump();
    expect(buildCount, 3);
    expect(find.text("50"), findsOneWidget);

    ///
    await tester.pump();
    expect(buildCount, 3);
  });

  testWidgets("Works with multiple variable", (tester) async {
    var counter1 = 0.notifier;
    var counter2 = 0.notifier;
    var buildCount = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: YazListenerWidget(
            changeNotifier: [counter1, counter2].notifyAll,
            builder: (c) {
              buildCount++;
              return Text((counter1.value + counter2.value).toString());
            }),
      ),
    ));

    /// first build
    expect(buildCount, 1);
    expect(find.text("0"), findsOneWidget);

    counter2.value++;
    await tester.pump();

    /// first build
    expect(buildCount, 2);
    expect(find.text("1"), findsOneWidget);

    counter1.value++;
    await tester.pump();

    /// first build
    expect(buildCount, 3);
    expect(find.text("2"), findsOneWidget);

    counter1.value = 10;
    await tester.pump();

    /// first build
    expect(buildCount, 4);
    expect(find.text("11"), findsOneWidget);
  });

  int _sum(List<int> l) {
    var i = 0;
    for (var o in l) {
      i += o;
    }
    return i;
  }

  testWidgets("Works collections (list) 2. Way", (tester) async {
    var notifiers = [0, 0].listenAll;
    var buildCount = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: YazListenerWidget(
            changeNotifier: notifiers,
            builder: (c) {
              buildCount++;
              return Text((_sum(notifiers.value)).toString());
            }),
      ),
    ));

    /// first build
    expect(buildCount, 1);
    expect(find.text("0"), findsOneWidget);

    notifiers[1]++;
    await tester.pump();

    expect(buildCount, 2);
    expect(find.text("1"), findsOneWidget);

    notifiers[0]++;
    await tester.pump();

    expect(buildCount, 3);
    expect(find.text("2"), findsOneWidget);

    notifiers[1] = 10;
    await tester.pump();

    expect(buildCount, 4);
    expect(find.text("11"), findsOneWidget);

    notifiers.add(30);
    await tester.pump();

    expect(buildCount, 5);
    expect(find.text("41"), findsOneWidget);

    notifiers.remove(10);
    await tester.pump();

    expect(buildCount, 6);
    expect(find.text("31"), findsOneWidget);
  });
}
