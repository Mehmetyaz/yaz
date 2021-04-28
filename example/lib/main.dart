import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'collections_changes_2.dart';
import 'collections_changes_3.dart';
import 'content_list.dart';
import 'logo_paint.dart';
import 'multiple_value_change.dart';
import 'single_variable_notifier.dart';
import 'stream_notifier.dart';
import 'string_change.dart';

void main() {
  runApp(const MyApp());
}

///
class MyApp extends StatelessWidget {
  ///
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Builder(builder: (c) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(c).push(MaterialPageRoute(builder: (c) {
                          return const YazLogo();
                        }));
                      },
                      child: const Text("Logo")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(c).push(MaterialPageRoute(builder: (c) {
                          return StreamNotifier();
                        }));
                      },
                      child: const Text("Stream Notifer")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(c).push(MaterialPageRoute(builder: (c) {
                          return StringChange();
                        }));
                      },
                      child: const Text("String Change")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(c).push(MaterialPageRoute(builder: (c) {
                          return SingleVariable();
                        }));
                      },
                      child: const Text("Single Variable State Manager")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(c).push(MaterialPageRoute(builder: (c) {
                          return MultipleValueChange();
                        }));
                      },
                      child: const Text("Multiple Variable State Manager")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(c).push(MaterialPageRoute(builder: (c) {
                          return CollectionChanges2();
                        }));
                      },
                      // ignore: lines_longer_than_80_chars
                      child: const Text(
                          "Collection State Manager (Method 2- MidWay)")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(c).push(MaterialPageRoute(builder: (c) {
                          return CollectionChanges3();
                        }));
                      },
                      // ignore: lines_longer_than_80_chars
                      child: const Text(
                          "Collection State Manager (Method 3- GoodWay)")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(c).push(MaterialPageRoute(builder: (c) {
                          return const ContentList();
                        }));
                      },
                      child: const Text("Content Controller"))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
