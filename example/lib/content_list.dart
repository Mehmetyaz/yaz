import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yaz/yaz.dart';

import 'content.dart';
import 'controller.dart';
import 'user.dart';

///
class ContentList extends StatefulWidget {
  ///
  const ContentList({Key? key}) : super(key: key);

  @override
  _ContentListState createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  List<Entry> entries = [];

  UserController controller = UserController();

  Future<void> init() async {
    await controller.init();
    entries = List.generate(
        50,
        (index) => Entry(
            entryId: Random().nextInt(5000).toString(),
            comment: "comment",
            createDate: DateTime.now(),
            userId: Random().nextInt(5).toString()));
    setState(() {});
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void _showSettings() {
    showModalBottomSheet(
        context: context,
        builder: (c) {
          return Container(
            height: 500,
            child: Column(
                children:
                    [Colors.green, Colors.amber, Colors.blue, Colors.black]
                        .map((e) => InkWell(
                              onTap: () {
                                UserOption("content_color").value = e;
                                Navigator.of(c).pop();
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                color: e,
                              ),
                            ))
                        .toList()),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Same users NOT load many times"),
      ),
      body: entries.isEmpty
          ? const CircularProgressIndicator()
          : SafeArea(
              child: Column(
                children: [
                  TextButton(
                      onPressed: _showSettings,
                      child: const Text("Set Content Color")),
                  Expanded(
                    child: ListView.builder(
                        itemCount: entries.length,
                        itemBuilder: (c, i) {
                          return EntryWidget(entry: entries[i]);
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}

///
class EntryWidget extends StatefulWidget {
  ///
  const EntryWidget({Key? key, required this.entry}) : super(key: key);

  ///
  final Entry entry;

  @override
  _EntryWidgetState createState() => _EntryWidgetState();
}

class _EntryWidgetState extends State<EntryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          FutureBuilder<User?>(
            future: UserController().getContent(widget.entry.userId),
            builder: (c, a) {
              if (a.connectionState != ConnectionState.done) {
                return const LinearProgressIndicator();
              }
              return OptionWrapper<Color>(
                userOption: UserOption<Color>("user_name_color",
                    defaultValue: Colors.amber),
                builder: (c, o) {
                  return Text(
                    a.data?.userName ?? "unknown",
                    style: TextStyle(color: o.value),
                  );
                },
              );
            },
          ),
          OptionWrapper<Color>(
            userOption:
                UserOption<Color>("content_color", defaultValue: Colors.green),
            builder: (c, o) {
              return Text(
                "${widget.entry.comment} ${widget.entry.createDate}",
                style:
                    TextStyle(color: UserOption<Color>("content_color").value),
              );
            },
          ),
        ],
      ),
    );
  }
}
