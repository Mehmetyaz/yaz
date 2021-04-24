import 'package:flutter/material.dart';

import 'content_list.dart';
import 'state_menager.dart';

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
                          return StateManager();
                        }));
                      },
                      child: const Text("State Manager")),
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
