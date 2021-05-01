import 'package:flutter/material.dart';
import 'package:yaz/yaz.dart';

///
class StreamNotifierExample extends StatelessWidget {
  ///
  StreamNotifierExample({Key? key})
      : stream =
            Stream<int>.periodic(const Duration(milliseconds: 500), (i) => i)
                .yazStreamWithDefault(0),
        super(key: key);

  ///
  final YazStream<int> stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(onPressed: stream.cancel, child: const Text("Stop")),
            stream.builder((context) => Text(stream.value.toString())),
          ],
        ),
      ),
    );
  }
}
