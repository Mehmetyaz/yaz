import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaz/yaz.dart';

void main() {
  testWidgets("Options Wrapper without initialize", (tester) async {
    var buildCount = 0;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: OptionWrapper(
            userOption: UserOption("icon_color", defaultValue: Colors.red),
            builder: (c, o) {
              buildCount++;
              return Icon(
                Icons.extension,
                color: o.value,
              );
            },
          ),
        ),
      ),
    ));

    expect(buildCount, 1);
    expect((tester.firstWidget(find.byIcon(Icons.extension)) as Icon).color,
        Colors.red);

    UserOption("icon_color").value = Colors.green;
    await tester.pump();

    expect(buildCount, 2);
    expect((tester.firstWidget(find.byIcon(Icons.extension)) as Icon).color,
        Colors.green);
  });

  testWidgets("Options Wrapper with initialize", (tester) async {
    var buildCount = 0;
    UserOptions()
        .init([UserOption.create(value: Colors.red, name: "text_color")]);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: OptionWrapper(
            userOption: UserOption("text_color"),
            builder: (c, o) {
              buildCount++;
              return Text(
                "color_test",
                style: TextStyle(color: o.value),
              );
            },
          ),
        ),
      ),
    ));

    expect(buildCount, 1);
    expect((tester.firstWidget(find.text("color_test")) as Text).style!.color,
        Colors.red);

    UserOption("text_color").value = Colors.green;
    await tester.pump();

    expect(buildCount, 2);
    expect((tester.firstWidget(find.text("color_test")) as Text).style!.color,
        Colors.green);
  });
}
