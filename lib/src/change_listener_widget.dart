library yaz_state;

import 'package:flutter/material.dart';

/// Listen changes and rebuilt if necessary
class YazListenerWidget<T extends ChangeNotifier> extends StatefulWidget {
  /// Listen changes and rebuilt if necessary
  const YazListenerWidget(
      {Key? key, required this.changeNotifier, required this.builder})
      : super(key: key);

  ///
  final T changeNotifier;

  ///
  /// Listen changes and rebuilt if necessary
  final WidgetBuilder builder;

  @override
  // ignore: no_logic_in_create_state
  YazListenerState<YazListenerWidget> createState() => YazListenerState();
}

///
class YazListenerState<T extends YazListenerWidget> extends State<T> {
  late int _notifierHashCode;

  @mustCallSuper
  @override
  void initState() {
    _listen();
    super.initState();
  }

  @mustCallSuper
  @override
  void dispose() {
    _remove();
    super.dispose();
  }

  void _listener() {
    if (mounted) {
      setState(() {});
    }
  }

  void _listen() {
    _notifierHashCode = widget.changeNotifier.hashCode;
    widget.changeNotifier.addListener(_listener);
  }

  void _remove() {
    widget.changeNotifier.removeListener(_listener);
  }

  @override
  void reassemble() {
    super.reassemble();
    _listen();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.changeNotifier.hashCode != _notifierHashCode) {
      _listen();
    }
    return widget.builder(context);
  }
}
